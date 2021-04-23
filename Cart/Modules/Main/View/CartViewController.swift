//
//  CartViewController.swift
//  Cart
//
//  Created by Andrey Volobuev on 22/04/2021.
//
import UIKit

final class CartViewController: UIViewController, UITableViewDataSource {
    
    private let repository: ProductItemsRepository
    
    private var container: ProductItemsContatiner?
    
    private lazy var tableView: UITableView = { tbv in
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.dataSource = self
        tbv.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
        return tbv
    }(UITableView())
    
    init(_ repository: ProductItemsRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        fetchItems()
    }
    
    private func addAllSubviews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.rightAnchor.constraint(equalTo: tableView.rightAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
    
    private func fetchItems() {
        repository.fetchItems { [weak self] result in
            switch result {
            case .success(let container):
                self?.container = container
                self?.tableView.reloadData()
            case .failure:
                // TODO: show error
                break
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? container?.items.count ?? 0 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier,
                                                 for: indexPath) as? ProductCell
        if let item = container?.items[indexPath.row] {
            cell?.configure(item.convert())
        }
        return cell!
    }
}
