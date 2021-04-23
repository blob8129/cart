//
//  ProductItemsRepositoryTests.swift
//  CartTests
//
//  Created by Andrey Volobuev on 23/04/2021.
//

import XCTest
@testable import Cart

final class NetworkServiceStub: NetworkServiceProtocol {
    
    let resultStub: Result<Data, Error>
    
    func get(result: (Result<Data, Error>) -> Void) {
        result(resultStub)
    }
    
    init(resultStub: Result<Data, Error>) {
        self.resultStub = resultStub
    }
}

class ProductItemsRepositoryTests: XCTestCase {
    
    enum TestError: Error, Equatable {
        case testNetworkError
        case testDecodingError
    }
    
    func testProductItemsRepositorySuccess() throws {
        let networkServiceStub = NetworkServiceStub(resultStub: .success(mockItemsData))
        
        let repository = ProductItemsRepository(networkService: networkServiceStub)
        
        repository.fetchItems { result in
            switch result {
            case .success(let container):
                XCTAssertEqual(container.items.count, 8)
            case .failure:
                XCTFail()
            }
        }
    }
    
    func testProductItemsRepositoryNetworkFalilure() throws {
        let networkServiceStub = NetworkServiceStub(resultStub: .failure(TestError.testNetworkError))
        
        let repository = ProductItemsRepository(networkService: networkServiceStub)
        
        repository.fetchItems { result in
            switch result {
            case .failure(let error as TestError):
                XCTAssertEqual(error, TestError.testNetworkError)
            default:
                XCTFail()
                
            }
        }
    }
    
    func testProductItemsRepositoryDecodingError() throws {
        let networkServiceStub = NetworkServiceStub(resultStub: .success(Data()))
        
        let repository = ProductItemsRepository(networkService: networkServiceStub)
        
        repository.fetchItems { result in
            switch result {
            case .failure(let error):
                XCTAssertTrue(true)
            default:
                XCTFail()
            }
        }
    }
}
