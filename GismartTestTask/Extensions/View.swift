//
//  View.swift
//  GismartTestTask
//
//  Created by Павел Кулицкий on 1.07.22.
//

import UIKit

extension UIView {

    //MARK: - Timer VC
    func setShadowForActiveOfferButton(roundetRect: CGRect, cornerRadii: CGSize) {
        self.layer.shadowColor = #colorLiteral(red: 0.9801548123, green: 0.03202562407, blue: 0.9361607432, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 25
        self.layer.shadowOpacity = 0.5
        
        let cgPath = UIBezierPath(roundedRect: roundetRect,
                                  byRoundingCorners: [.allCorners],
                                  cornerRadii: cornerRadii).cgPath
        
        self.layer.shadowPath = cgPath
    }

    func addGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        let firstColor = #colorLiteral(red: 0.3237385154, green: 0.3569169641, blue: 0.6614339948, alpha: 1).cgColor
        let secondColor = #colorLiteral(red: 0.9176470588, green: 0.2823529412, blue: 0.7333333333, alpha: 1).cgColor
        gradientLayer.colors = [firstColor, secondColor]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
        
}
