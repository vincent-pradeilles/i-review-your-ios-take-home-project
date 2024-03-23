//
//  ListDetailViewController.swift
//  PokemonGuide
//
//  Created by   on 15.03.2024.
//

import UIKit

final class ListDetailViewController: UIViewController {
    
    var viewModel: ListDetailViewModel!
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var detailLabel: UILabel!
    
    var item: PokemonItem!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    private func prepareView() {
        title = item.name
        detailLabel.text = item.description
        posterImageView.loadWebImage(url: item.imageUrl)
        
        detailLabel.accessibilityIdentifier = "detailLabel"
    }
}
