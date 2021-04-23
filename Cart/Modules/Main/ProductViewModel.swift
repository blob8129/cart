//
//  ProductViewModel.swift
//  Cart
//
//  Created by Andrey Volobuev on 23/04/2021.
//

import Foundation

struct ProductViewModel {
    let title: String
    let subtitle: String
    let isSubtitleHighlighted: Bool
    let price: String
    let initialQuntity: Int
    let imageURL: URL?
}

extension ProductItem {
    func convert() -> ProductViewModel {
        let subtitle: String
        let isSubtitleHighlighted: Bool
        switch availability {
        case .available:
            subtitle = product.nameExtra
            isSubtitleHighlighted = false
        case .notAvailable(let explanation):
            subtitle = explanation
            isSubtitleHighlighted = true
        }
        let imageURL = product.images.first?.thumbnail.url ?? URL(string: "https://kolonial.no/media/uploads/placeholder.jpg")
        
        return ProductViewModel(title: product.name,
                                subtitle: subtitle,
                                isSubtitleHighlighted: isSubtitleHighlighted,
                                price: "kr \(displayPriceTotal)",
                                initialQuntity: quantity,
                                imageURL: imageURL)
    }
}
