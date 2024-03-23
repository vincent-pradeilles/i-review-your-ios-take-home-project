//
//  UIKitListModelView.swift
//  PokemonGuide
//
//  Created by   on 14.03.2024.
//

import Foundation
import Combine

final class ListTableViewModel {
    
    var coordinator: ListTableCoordinator!

    private let httpTask: HTTPTaskProtocol
    
    init(httpTask: HTTPTaskProtocol) {
        self.httpTask = httpTask
    }
    
    func fetchPokemonItems() -> AnyPublisher<[PokemonItem], Error> {
        guard let url = URL(string: Constants.pokemonListUrl)
        else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        return httpTask.downloadWithCombine(url: url)
    }
}
