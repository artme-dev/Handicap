//
//  CustomizedButton.swift
//  HandicapCalculator
//
//  Created by Артём on 21.09.2021.
//

import UIKit

class CustomizedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.white, for: .normal)
        backgroundColor = .tintColor
        layer.cornerRadius = 8
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        addTarget(self, action: #selector(keyPressed), for: .touchUpInside)
    }

    func configure(title: String) {
        setTitle("Save", for: .normal)
    }
    
    @objc func keyPressed() {
        alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1.0
            }
        }
    }
}
