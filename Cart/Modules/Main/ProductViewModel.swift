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
    let quantityState: QuantityState
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
        
        let quantityState: QuantityState
        switch (quantity, availability) {
        case (_, .notAvailable):
            quantityState = .disabled
        case (let q, _) where q > 0:
            quantityState = .value(q)
        default:
            quantityState = .initial
        }
        
        return ProductViewModel(title: product.name,
                                subtitle: subtitle,
                                isSubtitleHighlighted: isSubtitleHighlighted,
                                price: "kr \(displayPriceTotal)",
                                quantityState: quantityState,
                                imageURL: imageURL)
    }
}
