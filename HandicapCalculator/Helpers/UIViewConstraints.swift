//
//  Constraints.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 31/03/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

struct ConstraintsConstants {
    let top: CGFloat?
    let trailing: CGFloat?
    let bottom: CGFloat?
    let leading: CGFloat?
    
    static let zero = ConstraintsConstants(top: 0, trailing: 0, bottom: 0, leading: 0)
}

extension UIView {
    
    func fillSuperview(using constants: ConstraintsConstants) {
        anchor(top: superview?.topAnchor,
               leading: superview?.leadingAnchor,
               bottom: superview?.bottomAnchor,
               trailing: superview?.trailingAnchor,
               padding: constants)
    }

    func fillSuperview() {
        fillSuperview(using: .zero)
    }
    
    func fillSuperviewSafe() {
        anchor(top: superview?.layoutMarginsGuide.topAnchor,
               leading: superview?.layoutMarginsGuide.leadingAnchor,
               bottom: superview?.layoutMarginsGuide.bottomAnchor,
               trailing: superview?.layoutMarginsGuide.trailingAnchor)
    }

    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    private func anchor(top: NSLayoutYAxisAnchor?,
                        leading: NSLayoutXAxisAnchor?,
                        bottom: NSLayoutYAxisAnchor?,
                        trailing: NSLayoutXAxisAnchor?,
                        padding: ConstraintsConstants = .zero) {
        
        if let top = top, let topPadding = padding.top {
            topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        if let leading = leading, let leadingPadding = padding.leading {
            leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        if let bottom = bottom, let bottomPadding = padding.bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }
        if let trailing = trailing, let trailingPadding = padding.trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding).isActive = true
        }
    }
    
}
