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
    
    private lazy var productImageView: UIImageView = { imv in
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.contentMode = .scaleAspectFit
        return imv
    }(UIImageView())
    
    private lazy var topLabel: UILabel = { lbl in
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(.required, for: .vertical)
        return lbl
    }(UILabel())
    
    private lazy var middleLabel: UILabel = { lbl in
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(.required, for: .vertical)
        return lbl
    }(UILabel())
    
    private lazy var bottomLabel: UILabel = { lbl in
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(.required, for: .vertical)
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
        selectionStyle = .none
        contentView.addSubview(productImageView)
        contentView.addSubview(topLabel)
        contentView.addSubview(middleLabel)
        contentView.addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            productImageView.topAnchor.constraint(equalTo: topLabel.topAnchor),
            bottomLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
            productImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            
            topLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 16),
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: topLabel.rightAnchor),
      
            middleLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 16),
            middleLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            contentView.rightAnchor.constraint(equalTo: middleLabel.rightAnchor),
            
            bottomLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 16),
            bottomLabel.topAnchor.constraint(equalTo: middleLabel.bottomAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: bottomLabel.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 16)
        ])
    }
    
    func configure(_ viewModel: ProductViewModel, imagesService: ImagesService) {
        topLabel.text = viewModel.title
        middleLabel.text = viewModel.subtitle
        bottomLabel.text = viewModel.price
        setDefaultStyle(isSubtitleHighlighted: viewModel.isSubtitleHighlighted)
        
        imageURL = viewModel.imageURL
        guard let imageURL = imageURL else {
            return
        }
        imagesService.fetchImage(at: imageURL) { [weak self] result in
            switch result {
            case .success((let fetchedImageUrl, let data)):
                DispatchQueue.main.async {
                    if fetchedImageUrl == imageURL {
                        self?.productImageView.image = UIImage(data: data)
                    }
                }
            case .failure:
                // TODO: Show local placeholder
                break
            }
        }
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
