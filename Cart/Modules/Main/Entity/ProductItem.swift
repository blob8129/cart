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
//        "images": [
//            {
//                "thumbnail": {
//                    "url": "https://bilder.kolonial.no/produkter/33856a80-7b73-4cd3-b847-c443288ca7ee.jpeg?fit=max&w=500&s=6cdb074aa1039963eaf4d8de96c17e9f"
//                },
//                "large": {
//                    "url": "https://kolonial.no/media/uploads/public/110/375/1186775-5cbe8-product_large.jpg"
//                }
//            }
//        ],
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
    let items: [ProductItem]
}
