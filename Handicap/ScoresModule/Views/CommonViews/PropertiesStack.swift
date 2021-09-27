//
//  PropertiesStack.swift
//  HandicapCalculator
//
//  Created by Артём on 23.09.2021.
//

import UIKit

class PropertiesStack: UIStackView {
    
    static let parameterNameFont = UIFont.systemFont(ofSize: 14)
    static let parameterNameColor = UIColor.systemGray3
    static let parameterValueFont = UIFont.systemFont(ofSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
    }
    
    static func propertyView(named name: String, valueLabel: UILabel) -> UIView {
        
        let propertyStack = UIStackView()
        propertyStack.translatesAutoresizingMaskIntoConstraints = false
        propertyStack.axis = .vertical
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textAlignment = .center
        
        nameLabel.textColor = PropertiesStack.parameterNameColor
        nameLabel.font = PropertiesStack.parameterNameFont
        
        propertyStack.addArrangedSubview(valueLabel)
        propertyStack.addArrangedSubview(nameLabel)
        
        return propertyStack
    }
    
    static func createValueLabel() -> UILabel {
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textAlignment = .center
        valueLabel.font = PropertiesStack.parameterValueFont
        
        return valueLabel
    }
}
