//
//  Screen.swift
//  GismartTestTask
//
//  Created by Павел Кулицкий on 1.07.22.
//

import Foundation
import UIKit

struct Screen {
    
    static let shared = Screen()
    
    //Screen height and width
    let height = UIScreen.main.bounds.height
    let width = UIScreen.main.bounds.width
    
}

struct ScreenSafeArea {
    
    lazy var view = UIView()
    
    //Insets of safe area from view bounds
    lazy var bottomInset = view.safeAreaInsets.bottom
    lazy var leftInset = view.safeAreaInsets.left
    lazy var rightInset = view.safeAreaInsets.right
    
    //Safe area width and height
    lazy var safeAreaWidth = view.bounds.width - leftInset - rightInset
    lazy var safeAreaHeight = view.bounds.height - bottomInset
    
    init(view: UIView) {
        self.view = view
    }
    
}
