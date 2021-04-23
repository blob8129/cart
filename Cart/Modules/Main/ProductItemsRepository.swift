//
//  ProductItemsRepository.swift
//  Cart
//
//  Created by Andrey Volobuev on 23/04/2021.
//

import Foundation

final class ProductItemsRepository {
    
    private lazy var decoder: JSONDecoder = { dcd in
        dcd.keyDecodingStrategy = .convertFromSnakeCase
        return dcd
    }(JSONDecoder())
    
    func fetchItems(result: (Result<ProductItemsContatiner, Error>) -> Void) {
        do {
            result(.success( try decoder.decode(ProductItemsContatiner.self, from: mockItemsData)))
        } catch let error {
            result(.failure(error))
        }
    }
}
