//
//  ListTableViewController.swift
//  PokemonGuide
//
//  Created by   on 15.03.2024.
//

import UIKit
import Combine

final class ListTableViewController: UIViewController {
    
    var viewModel: ListTableViewModel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var cancellables = Set<AnyCancellable>()

    // This should be in the ListTableViewModel
    private var items: [PokemonItem] = [] {
        didSet {
          tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        viewModel.fetchPokemonItems()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                // Explain why the error is ignored
            } receiveValue: { [weak self] items in
                self?.items = items
            }
            .store(in: &cancellables)
    }
    
    private func prepareView() {
        tableView.register(
            UINib(
                nibName: "ListViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "ListViewCell"
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Pokémon"
    }
}

extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as? ListViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(item: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.coordinator.showDetail(with: items[indexPath.row])
    }
}
