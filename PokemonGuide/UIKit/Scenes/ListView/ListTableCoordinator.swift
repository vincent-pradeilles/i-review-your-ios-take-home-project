//
//  ListTableViewCoordinator.swift
//  PokemonGuide
//
//  Created by   on 15.03.2024.
//

import UIKit

final class ListTableCoordinator {
    
    weak var navigator: UINavigationController?
    
    public init(navigator: UINavigationController?) {
        self.navigator = navigator
    }
    
    public func start() {
        let view = ListTableViewController.loadController()
        view.viewModel = ListTableViewModel(httpTask: HTTPTask())
        view.viewModel.coordinator = self
        
        navigator?.pushViewController(view, animated: true)
    }
    
    func showDetail(with item: PokemonItem) {
        ListDetailCoordinator(navigator: navigator).start(with: item)
    }
}
