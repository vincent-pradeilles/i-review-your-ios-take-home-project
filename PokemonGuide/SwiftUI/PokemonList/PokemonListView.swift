//
//  PokemonList.swift
//  PokemonGuide
//
//  Created by   on 14.03.2024.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject private var viewModel: PokemonListViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: PokemonListViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.items, id: \.self) { item in
                        NavigationLink(value: item) {
                            PokemonRowView(item: item)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer()
            }
            .accessibilityIdentifier("DetailButton")
            .navigationDestination(for: PokemonItem.self) { item in
                PokemonDetailView(viewModel: PokemonDetailViewModel(item: item))
            }
            .navigationBarItems(
                leading: Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            )
            .navigationTitle("Pokémon")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                Color("toolbarColor"),
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .task {
            await viewModel.fetchPokemonItems()
        }
    }
}

#Preview {
    let httpTask = HTTPTask()
    let vm = PokemonListViewModel(httpTask: httpTask)
    return PokemonListView(viewModel: vm)
}
