//
//  ProductCell.swift
//  Cart
//
//  Created by Andrey Volobuev on 23/04/2021.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    static let reuseIdentifier = "ProductCell"
    
    private var imageURL: URL?
    
    private lazy var topLabel: UILabel = { lbl in
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }(UILabel())
    
    private lazy var middleLabel: UILabel = { lbl in
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }(UILabel())
    
    private lazy var bottomLabel: UILabel = { lbl in
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        contentView.addSubview(topLabel)
        contentView.addSubview(middleLabel)
        contentView.addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            topLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: topLabel.rightAnchor),
      
            middleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            middleLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            contentView.rightAnchor.constraint(equalTo: middleLabel.rightAnchor),
            
            bottomLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bottomLabel.topAnchor.constraint(equalTo: middleLabel.bottomAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: bottomLabel.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 16)
        ])
    }
    
    func configure(_ viewModel: ProductViewModel) {
        imageURL = viewModel.imageURL
        topLabel.text = viewModel.title
        middleLabel.text = viewModel.subtitle
        bottomLabel.text = viewModel.price
        setDefaultStyle(isSubtitleHighlighted: viewModel.isSubtitleHighlighted)
    }
    
    private func setDefaultStyle(isSubtitleHighlighted: Bool) {
        middleLabel.textColor = isSubtitleHighlighted ? .red : .secondaryLabel
    
        topLabel.font = .preferredFont(forTextStyle: .headline)
        middleLabel.font = .preferredFont(forTextStyle: .subheadline)
        bottomLabel.font = .preferredFont(forTextStyle: .title3)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageURL = nil
    }
}
