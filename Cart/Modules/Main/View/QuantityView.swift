//
//  QuantityView.swift
//  Cart
//
//  Created by Andrey Volobuev on 24/04/2021.
//

import UIKit

enum QuantityState: Equatable {
    case initial
    case value(Int)
    case disabled
    
    func incrementingValue() -> QuantityState {
        switch self {
        case .initial:
            return .value(1)
        case .value(let v):
            return .value(v + 1)
        case .disabled:
            return .disabled
        }
    }
    
    func decrementingValue() -> QuantityState {
        switch self {
        case .initial:
            return .initial
        case .value(let v):
            if v > 1 {
                return .value(v - 1)
            } else {
                return .initial
            }
        case .disabled:
            return .disabled
        }
    }
}

final class QuantityView: UIView {
    
    var quantityState: QuantityState = .initial {
        didSet {
            minusButton.isHidden = false
            label.isHidden = false
            plusButton.isHidden = false
            minusButton.setImage(UIImage(systemName: "minus.circle", withConfiguration: imagesConfig), for: .normal)
            minusButton.tintColor = .secondaryLabel
            plusButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: imagesConfig), for: .normal)
            plusButton.tintColor = .secondaryLabel
            switch quantityState {
            case .initial:
                minusButton.isHidden = true
                label.isHidden = true
                plusButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: imagesConfig), for: .normal)
                plusButton.tintColor = .orange
            case .value(let quantity):
                label.text = "\(quantity)"
            case .disabled:
                minusButton.isHidden = true
                label.isHidden = true
                plusButton.isHidden = true
            }
        }
    }
    
    private lazy var minusButton: UIButton = { btn in
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 4)
        btn.addTarget(self, action: #selector(decrementValue), for: .touchUpInside)
        btn.backgroundColor = .clear
        return btn
    }(UIButton(type: .system))
    
    private lazy var label: UILabel = { lbl in
        return lbl
    }(UILabel())
    
    private lazy var plusButton: UIButton = { btn in
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 24)
        btn.addTarget(self, action: #selector(incrementValue), for: .touchUpInside)
        btn.backgroundColor = .clear
        return btn
    }(UIButton(type: .system))
    
    private lazy var stackView: UIStackView = { stv in
        stv.translatesAutoresizingMaskIntoConstraints = false
        stv.axis = .horizontal
        stv.alignment = .center
        return stv
    }(UIStackView(arrangedSubviews: [minusButton, label, plusButton]))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            rightAnchor.constraint(equalTo: stackView.rightAnchor),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
        ])
    }
    
    @objc func incrementValue() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: [], animations: {
                        self.quantityState = self.quantityState.incrementingValue()
        }, completion: nil)
    }
    
    @objc func decrementValue() {
        UIView.animate(withDuration: 0.2) {
            self.quantityState = self.quantityState.decrementingValue()
        }
    }
    
    override var firstBaselineAnchor: NSLayoutYAxisAnchor {
        label.firstBaselineAnchor
    }
    
    private var imagesConfig = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .title2), scale: .large)
}
