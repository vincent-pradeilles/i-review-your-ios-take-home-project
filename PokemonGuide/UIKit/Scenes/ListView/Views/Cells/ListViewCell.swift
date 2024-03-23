//
//  ListViewCell.swift
//  PokemonGuide
//
//  Created by   on 14.03.2024.
//

import UIKit

final class ListViewCell: UITableViewCell {
    
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImage: UIImageView!
    
    func configure(item: PokemonItem) {
        titleLabel.text = item.name
        subtitleLabel.text = item.description
        posterImage.loadWebImage(url: item.imageUrl)
    }
}
