//
//  CartViewController.swift
//  Cart
//
//  Created by Andrey Volobuev on 22/04/2021.
//
import UIKit

final class CartViewController: UIViewController, UITableViewDataSource {
    
    private let repository: ProductItemsRepository
    private let imagesService: ImagesService
    private var container: ProductItemsContatiner?
    
    private lazy var tableView: UITableView = { tbv in
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.dataSource = self
        tbv.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
        tbv.register(ExtraCell.self, forCellReuseIdentifier: ExtraCell.reuseIdentifier)
        return tbv
    }(UITableView())
    
    init(_ repository: ProductItemsRepository, imagesService: ImagesService) {
        self.repository = repository
        self.imagesService = imagesService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: (view.frame.width * 0.2) + 32,
                                                bottom: 0,
                                                right: 0)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Cart"
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
        guard let container = container else { return 0 }
        return section == 0 ? container.items.count : container.extraLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let container = container else { return UITableViewCell() }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier,
                                                     for: indexPath) as? ProductCell
            cell?.configure(container.items[indexPath.row].convert(), imagesService: imagesService)
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ExtraCell.reuseIdentifier,
                                                     for: indexPath) as? ExtraCell
            let extraItem = container.extraLines[indexPath.row]
            cell?.textLabel?.text = extraItem.description
            cell?.detailTextLabel?.text = extraItem.grossAmount
            return cell!
        }
    }
}
