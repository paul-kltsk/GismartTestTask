//
//  Button.swift
//  GismartTestTask
//
//  Created by Павел Кулицкий on 30.06.22.
//

import UIKit

extension UIButton {
    
    func setupActivateOfferButton(size: CGFloat) {
        self.setTitle("ACTIVATE OFFER", for: .normal)
        guard let font = UIFont(name:".AppleSystemUIFontDemi", size: size) else { return }
        self.titleLabel?.font = font
        self.layer.masksToBounds = true
        self.tintColor = .white
    }
        
}


