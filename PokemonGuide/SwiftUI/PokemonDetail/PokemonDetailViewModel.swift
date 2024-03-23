//
//  PokemonDetailViewModel.swift
//  PokemonGuide
//
//  Created by   on 19.03.2024.
//

import SwiftUI

class PokemonDetailViewModel: ObservableObject {
    @Published var image: UIImage?
    let item: PokemonItem
    
    init(item: PokemonItem) {
        self.item = item
    }
    
    func fetchImage() async {
        guard let url = URL(string: item.imageUrl) else { return }
        
        let image = try? await WebImageLoader(url: url).downloadWithAsync()
        await MainActor.run {
            self.image = image
        }
    }
}
