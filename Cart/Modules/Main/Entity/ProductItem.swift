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
        struct ImageContainer: Decodable {
            struct Image:Decodable {
                let url: URL
            }
            let thumbnail: Image
        }
        let id: Int
        let images: [ImageContainer]
        let name: String
        let nameExtra: String
        let unitPriceQuantityAbbreviation: String
    }
    
    enum Availability: Decodable, Equatable, CustomStringConvertible {
        
        case available
        case notAvailable(String)
        
        enum CodingKeys: CodingKey {
            case isAvailable
            case descriptionShort
        }
        
        var description: String {
            switch self {
            case .available:
                return "available"
            case .notAvailable(let text):
                return text
            }
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
    struct Extra: Decodable {
        let description: String
        let grossAmount: String
    }
    
    let items: [ProductItem]
    let extraLines: [Extra]
}
