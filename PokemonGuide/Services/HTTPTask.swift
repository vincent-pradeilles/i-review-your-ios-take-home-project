//
//  HTTPTask.swift
//  PokemonGuide
//
//  Created by   on 14.03.2024.
//

import UIKit
import Combine

protocol HTTPTaskProtocol {
    func downloadWithAsync(url: URL) async throws -> [PokemonItem]
    func downloadWithCombine(url: URL) -> AnyPublisher<[PokemonItem], Error>
}

final class HTTPTask: HTTPTaskProtocol {
    func downloadWithCombine(url: URL) -> AnyPublisher<[PokemonItem], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(handleResponse)
            .mapError({ $0 }) // 👈 not sure if really needed
            .eraseToAnyPublisher()
    }
    
    func downloadWithAsync(url: URL) async throws -> [PokemonItem] {
        do { // this do block is not needed, because the method is already throwing
            // delegate argument is already nil by default
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return try handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
    
    private func handleResponse(data: Data?, response: URLResponse?) throws -> [PokemonItem] {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        do { // this do block is not needed, because the method is already throwing
            let result = try JSONDecoder().decode([PokemonItem].self, from: data)
            return result
        } catch {
            throw error
        }
    }
}
