//
//  UIImageView+Ext.swift
//  PokemonGuide
//
//  Created by   on 14.03.2024.
//

import UIKit

extension UIImageView {
    func loadWebImage(url: String) {
        guard let url = URL(string: url) else { return }
        
        Task {
            let loader = WebImageLoader(url: url)
            let image = try? await loader.downloadWithAsync()
            self.image = image
            
            // You dont need to use MainActor.run
            // Because UIImageView already run on MainActor
            // @MainActor class UIImageView : UIView
//            await MainActor.run {
//                self.image = image
//            }
        }
    }
}
