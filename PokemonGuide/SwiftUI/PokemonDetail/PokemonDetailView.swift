//
//  PokemonDetailView.swift
//  PokemonGuide
//
//  Created by   on 14.03.2024.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var viewModel: PokemonDetailViewModel
    
    init(viewModel: PokemonDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
            }
            
            ScrollView {
                Text(viewModel.item.description)
                    .accessibilityIdentifier("detailTitle")
                    .padding()
            }
        }
        .navigationTitle(viewModel.item.name)
        .toolbarBackground(
            Color("toolbarColor"),
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .task {
            await viewModel.fetchImage()
        }
    }
}

#Preview {
    PokemonDetailView(viewModel: PokemonDetailViewModel(item: PokemonItem(id: 1,
                                                                     name: "Bulbasaur",
                                                                     description: "There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.",
                                                                     imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")))
}
