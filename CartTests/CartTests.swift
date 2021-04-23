//
//  CartTests.swift
//  CartTests
//
//  Created by Andrey Volobuev on 22/04/2021.
//

import XCTest
@testable import Cart

class CartTests: XCTestCase {

    private lazy var testDecoder: JSONDecoder = { dcd in
        dcd.keyDecodingStrategy = .convertFromSnakeCase
        return dcd
    }(JSONDecoder())
    
    func testProductItemDecoding() throws {
        let data =
        """
        {
            "product": {
                "id": 23551,
                "full_name": "Gresskar Butternut Portugal/ Spania, 750 g",
                "brand": null,
                "brand_id": null,
                "name": "Gresskar Butternut",
                "name_extra": "Portugal/ Spania, 750 g",
                "front_url": "https://kolonial.no/produkter/23551-gresskar-butternut-portugal-spania/",
                "images": [
                    {
                        "thumbnail": {
                            "url": "https://kolonial.no/media/uploads/public/386/259/130259-3a5f7-product_detail.jpg"
                        },
                        "large": {
                            "url": "https://kolonial.no/media/uploads/public/386/259/130259-3a5f7-product_large.jpg"
                        }
                    }
                ],
                "gross_price": "33.00",
                "gross_unit_price": "44.00",
                "unit_price_quantity_abbreviation": "kg",
                "unit_price_quantity_name": "Kilogram",
                "discount": null,
                "promotion": null,
                "availability": {
                    "is_available": true,
                    "code": "available",
                    "description": "",
                    "description_short": ""
                },
                "client_classifiers": []
            },
            "quantity": 1,
            "display_price_total": "33.00",
            "discounted_display_price_total": "33.00",
            "availability": {
                "is_available": true,
                "code": "available",
                "description": "",
                "description_short": ""
            }
        }
        """.data(using: .utf8)!
        
        XCTAssertNoThrow(try testDecoder.decode(ProductItem.self, from: data))
        let item = try testDecoder.decode(ProductItem.self, from: data)
        
        XCTAssertEqual(item.product.id, 23551)
        XCTAssertEqual(item.product.name, "Gresskar Butternut")
        XCTAssertEqual(item.product.nameExtra, "Portugal/ Spania, 750 g")
        XCTAssertEqual(item.product.unitPriceQuantityAbbreviation, "kg")
        XCTAssertEqual(item.availability, .available)
        XCTAssertEqual(item.quantity, 1)
        XCTAssertEqual(item.displayPriceTotal, "33.00")
    }
    
    func testAllItemsDecoding() throws {
        XCTAssertNoThrow(try testDecoder.decode(ProductItemsContatiner.self, from: mockItemsData))
    }
}
