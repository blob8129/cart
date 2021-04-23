//
//  CartViewController.swift
//  Cart
//
//  Created by Andrey Volobuev on 22/04/2021.
//
import UIKit

final class CartViewController: UIViewController {
    
    private let repository: ProductItemsRepository
    
    var container: ProductItemsContatiner?
    
    init(_ repository: ProductItemsRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func addAllSubviews() {
    
    }
    
    private func fetchItems() {
        repository.fetchItems { [weak self] result in
            switch result {
            case .success(let container):
                self?.container = container
            case .failure:
                // TODO: show error
                break
            }
        }
    }
}

