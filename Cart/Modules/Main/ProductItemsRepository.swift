//
//  ProductItemsRepository.swift
//  Cart
//
//  Created by Andrey Volobuev on 23/04/2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func get(result: (Result<Data, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func get(result: (Result<Data, Error>) -> Void) {
        result(.success(mockItemsData))
    }
}

final class ProductItemsRepository {
    
    private let networkService: NetworkServiceProtocol
    
    private lazy var decoder: JSONDecoder = { dcd in
        dcd.keyDecodingStrategy = .convertFromSnakeCase
        return dcd
    }(JSONDecoder())
    
    func fetchItems(result: (Result<ProductItemsContatiner, Error>) -> Void) {
        networkService.get { networkResult in
            switch networkResult {
            case .success(let data):
                do {
                    result(.success( try decoder.decode(ProductItemsContatiner.self, from: data)))
                } catch let decodingError {
                    result(.failure(decodingError))
                }
            case .failure(let networkError):
                result(.failure(networkError))
            }
        }
    }
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
}
