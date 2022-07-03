//
//  Label.swift
//  GismartTestTask
//
//  Created by Павел Кулицкий on 30.06.22.
//

import UIKit

extension UILabel {
    
    //MARK: - in TimerViewController
    func setupLabel(font: UIFont, numberOflines: Int, text: String, color: UIColor) {
        self.font = font
        self.numberOfLines = numberOflines
        self.adjustsFontSizeToFitWidth = true
        self.text = text
        self.sizeToFit()
        self.textAlignment = .center
        self.textColor = color
    }
    
    //in TimerViewController
    func setupBottomLabel(text: String, size: CGFloat) {
        guard let font = UIFont(name: ".AppleSystemUIFont", size: size) else { return }
        self.font = font
        self.numberOfLines = 1
        self.text = text
        self.adjustsFontSizeToFitWidth = true
        self.sizeToFit()
        self.textAlignment = .center
        self.textColor = .systemGray
    }
    
    //in TimerViewController
    func setupTimerLabel(size: CGFloat) {
        guard let font = UIFont(name: ".AppleSystemUIFontEmphasized", size: size) else { return }
        self.font = font
        self.numberOfLines = 1
        self.text = String(format: "%02d", 0)
        self.layer.masksToBounds = true
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
        self.textColor = .white
        self.backgroundColor = #colorLiteral(red: 0.1686274707, green: 0.1686274707, blue: 0.1686274707, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //in TimerViewController
    func setupColonLabel(size: CGFloat) {
        guard let font = UIFont(name: ".AppleSystemUIFontEmphasized", size: size) else { return }
        self.font = font
        self.numberOfLines = 1
        self.text = ":"
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
