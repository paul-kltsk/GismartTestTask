//
//  StackView.swift
//  GismartTestTask
//
//  Created by Павел Кулицкий on 29.06.22.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat,
                     distribution: UIStackView.Distribution,
                     mask: Bool) {
        
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = mask
        
    }
    
    
    
}
