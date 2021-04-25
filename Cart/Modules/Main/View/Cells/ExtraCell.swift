//
//  ExtraCell.swift
//  Cart
//
//  Created by Andrey Volobuev on 25/04/2021.
//

import UIKit

final class ExtraCell: UITableViewCell {
    
    static let reuseIdentifier = "ExtraLinesCellReuseIdentifier"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
