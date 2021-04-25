//
//  ProductViewModelTests.swift
//  CartTests
//
//  Created by Andrey Volobuev on 25/04/2021.
//

import XCTest
@testable import Cart

class ProductViewModelTests: XCTestCase {

    let testProduct = ProductItem.Product(id: 42,
                                          images: [],
                                          name: "TestProductName",
                                          nameExtra: "TestProductNameExtra",
                                          unitPriceQuantityAbbreviation: "kg")
    func testInitialState() throws {
        let viewModel = ProductItem(product: testProduct,
                                    availability: .available,
                                    quantity: 0,
                                    displayPriceTotal: "42").convert()
        
        XCTAssertEqual(viewModel.title, "TestProductName")
        XCTAssertEqual(viewModel.subtitle, "TestProductNameExtra")
        XCTAssertEqual(viewModel.isSubtitleHighlighted, false)
        XCTAssertEqual(viewModel.quantityState, .initial)
    }

    func testNotAvailable() throws {
        let viewModel = ProductItem(product: testProduct,
                                    availability: .notAvailable("TestNotAvailableExplanation"),
                                    quantity: 42,
                                    displayPriceTotal: "42").convert()
        
        XCTAssertEqual(viewModel.title, "TestProductName")
        XCTAssertEqual(viewModel.subtitle, "TestNotAvailableExplanation")
        XCTAssertEqual(viewModel.isSubtitleHighlighted, true)
        XCTAssertEqual(viewModel.quantityState, .disabled)
    }
    
    func testInitialQuantityValue() throws {
        let viewModel = ProductItem(product: testProduct,
                                    availability: .available,
                                    quantity: 42,
                                    displayPriceTotal: "42").convert()
        
        XCTAssertEqual(viewModel.title, "TestProductName")
        XCTAssertEqual(viewModel.subtitle, "TestProductNameExtra")
        XCTAssertEqual(viewModel.isSubtitleHighlighted, false)
        XCTAssertEqual(viewModel.quantityState, .value(42))
    }
}
