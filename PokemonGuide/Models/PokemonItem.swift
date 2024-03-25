//
//  PokemonItem.swift
//  PokemonGuide
//
//  Created by   on 14.03.2024.
//

import Foundation

struct PokemonItem: Codable, Hashable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: String // 👈 would be better if URL, because it centralizes the check for validity
    
    static func ==(lhs: PokemonItem, rhs: PokemonItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
