//
//  NamedField.swift
//  HandicapCalculator
//
//  Created by Артём on 21.09.2021.
//

import UIKit

class NamedFieldView: UIView {
    
    static let fieldTextColor: UIColor = .gray
    
    private let fieldStack: UIStackView = {
        let fieldStack = UIStackView()
        fieldStack.translatesAutoresizingMaskIntoConstraints = false
        fieldStack.axis = .vertical
        fieldStack.spacing = 8
        return fieldStack
    }()
    
    private let nameLabel = UILabel()
    
    let field: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.textColor = NamedFieldView.fieldTextColor
        field.layer.borderColor = UIColor.tintColor.cgColor
        return field
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(fieldStack)
        fieldStack.fillSuperview()
        fieldStack.addArrangedSubview(nameLabel)
        fieldStack.addArrangedSubview(field)
    }
    
    func configure(name: String, placeholder: String? = nil) {
        nameLabel.text = name
        field.placeholder = placeholder
    }
}
