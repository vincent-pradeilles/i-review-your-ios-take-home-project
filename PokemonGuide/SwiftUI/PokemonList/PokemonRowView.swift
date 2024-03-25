//
//  PokemonRowView.swift
//  PokemonGuide
//
//  Created by   on 14.03.2024.
//

import SwiftUI

struct PokemonRowView: View {
    let item: PokemonItem
    
    @State private var image: UIImage?

    var body: some View {
        HStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                Text(item.description)
                    .font(.system(size: 16))
            }
        }
        .task {
            guard let url = URL(string: item.imageUrl) else { return }
            
            let image = try? await WebImageLoader(url: url).downloadWithAsync()
            await MainActor.run { // not sure if needed, since View is already @MainActor
                self.image = image
            }
        }
    }
}

#Preview {
    PokemonRowView(item: PokemonItem(id: 1,
                                     name: "Bulbasaur",
                                     description: "There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.",
                                     imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"))
}
