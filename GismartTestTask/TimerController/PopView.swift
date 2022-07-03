//
//  PopView.swift
//  GismartTestTask
//
//  Created by Павел Кулицкий on 1.07.22.
//

import Foundation
import UIKit

class PopView: UIView {
    
    private var time = "00:00"
    private let alertView = UIView()
    private var shadowView = UIView()
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    
    //MARK: - Init
    init(frame: CGRect,time: String) {
        super.init(frame: frame)
            
        self.frame = UIScreen.main.bounds
        self.backgroundColor = .black.withAlphaComponent(0.7)
        
        setupView()
        setupUI()
        setupFrame()
        
        secondLabel.text! += time
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup view
    private func setupView() {
        self.addSubview(alertView)
        alertView.addSubview(shadowView)
        alertView.addSubview(firstLabel)
        alertView.addSubview(secondLabel)

    }
    
    //MARK: - Setup UI Elements
    private func setupUI() {
        
        //alert view
        alertView.backgroundColor = #colorLiteral(red: 0, green: 0.05504736304, blue: 0.3074657917, alpha: 1)
        alertView.layer.masksToBounds = false

        //shadow view
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.2
        
        //first label
        firstLabel.text = "Great!"
        firstLabel.font = UIFont(name: ".AppleSystemUIFontEmphasized", size: getSizeOrInsets(point: 25))
        firstLabel.adjustsFontSizeToFitWidth = true
        firstLabel.textAlignment = .center
        firstLabel.textColor = .white
        firstLabel.minimumScaleFactor = 15
        firstLabel.sizeToFit()
        
        
        //second label
        secondLabel.text = "Offer activated at "
        secondLabel.adjustsFontSizeToFitWidth = true
        secondLabel.font = UIFont(name: ".AppleSystemUIFontEmphasized", size: getSizeOrInsets(point: 20))
        secondLabel.textAlignment = .center
        secondLabel.textColor = .white
        secondLabel.sizeToFit()
        
    }
    
    //MARK: - Setup frame for phone
    private func setupFrame() {

        alertView.frame = CGRect(x: 0, y: 0,
                                 width: Screen.shared.width/3,
                                 height: Screen.shared.height/3)
        alertView.center = self.center
        
        alertView.layer.cornerRadius = alertView.frame.height/7
        
        firstLabel.frame = CGRect(x: 0, y: 0,
                                  width: firstLabel.frame.width,
                                  height: firstLabel.frame.height)
        firstLabel.center = CGPoint(x: alertView.bounds.maxX/2,
                                    y: alertView.bounds.maxY/4)
        
        shadowView.frame = CGRect(x: 0, y: 0,
                                  width: firstLabel.frame.width,
                                  height: firstLabel.frame.height)
        shadowView.center = CGPoint(x: alertView.bounds.maxX/2,
                                    y: alertView.bounds.maxY/4)
        
        let cgPath = UIBezierPath(roundedRect: shadowView.bounds,
                                                       byRoundingCorners: [.allCorners],
                                                       cornerRadii: CGSize(width: firstLabel.frame.width / 3,
                                                                           height: firstLabel.frame.height / 3)).cgPath

        shadowView.layer.shadowPath = cgPath
        
        
        secondLabel.frame = CGRect(x: 0, y: 0,
                                   width: alertView.bounds.maxX * 0.9,
                                  height: secondLabel.frame.height)
        secondLabel.center = CGPoint(x: alertView.bounds.maxX/2,
                                     y: firstLabel.bounds.maxY + alertView.bounds.maxY/2.5)
        
    }
    
    private func getSizeOrInsets(point: CGFloat) -> CGFloat {
        return Screen.shared.height * point / 390
    }
    
}
