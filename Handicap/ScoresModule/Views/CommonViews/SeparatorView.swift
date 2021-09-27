//
//  SeparatorView.swift
//  HandicapCalculator
//
//  Created by Артём on 23.09.2021.
//

import UIKit

class SeparatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .systemGray6
        heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
