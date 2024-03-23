//
//  MockHTTPTask.swift
//  PokemonGuideTests
//
//  Created by   on 15.03.2024.
//

import XCTest
import Combine
@testable import PokemonGuide

class MockHTTPTask: HTTPTaskProtocol {
    var shouldThrowError = false
    var itemsToReturn: [PokemonItem] = []
    
    func downloadWithAsync(url: URL) async throws -> [PokemonItem] {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        return itemsToReturn
    }
    
    func downloadWithCombine(url: URL) -> AnyPublisher<[PokemonItem], Error> {
        if shouldThrowError {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        } else {
            return Just(itemsToReturn).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
    
    func downloadWithEscaping(url: URL, completionHandler: @escaping ([PokemonItem]?, Error?) -> ()) {
        if shouldThrowError {
            completionHandler(nil, URLError(.badServerResponse))
        } else {
            completionHandler(itemsToReturn, nil)
        }
    }
}
