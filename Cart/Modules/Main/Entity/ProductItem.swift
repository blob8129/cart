//
//  ProductItem.swift
//  Cart
//
//  Created by Andrey Volobuev on 22/04/2021.
//

import Foundation


struct ProductItem: Decodable {

    let product: Product
    let availability: Availability
    let quantity: Int
    let displayPriceTotal: String
    
    struct Product: Decodable {
        let id: Int
        let name: String
        let nameExtra: String
        let unitPriceQuantityAbbreviation: String
    }
    
    enum Availability: Decodable, Equatable {
        case available
        case notAvailable(String)
        
        enum CodingKeys: CodingKey {
            case isAvailable
            case descriptionShort
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let isAvailable = try container.decode(Bool.self, forKey: .isAvailable)
            if isAvailable {
                self = .available
            } else {
                self = .notAvailable(try container.decodeIfPresent(String.self, forKey: .descriptionShort) ?? "")
            }
        }
    }
}

struct ProductItemsContatiner: Decodable {
    let items: [ProductItem]
}
