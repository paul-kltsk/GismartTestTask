//
//  TimerViewController.swift
//  GismartTestTask
//
//  Created by Павел Кулицкий on 29.06.22.
//

import Foundation
import UIKit

class TimerViewContoller: UIViewController {
    
    private let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom

    private lazy var screen = ScreenSafeArea(view: view)
    
    private var imageView = UIImageView()
    
    private var firstLabel = UILabel() // text: LAST-MINUTE CHANCE!\nto claim your offer
    private var secondLabel = UILabel() // text: 90% OFF
    private var thirdLabel = UILabel() // text: For true music fans
    
    //Timer
    private var timer: Timer = Timer()
    static var secondsInDay = 86400
    private let daysLabel = UILabel() // days
    private let hoursLabel = UILabel() // hours
    private let minutesLabel = UILabel() // minutes
    private let secondsLabel = UILabel() // seconds
    
    private let colon1 = UILabel() // first colon
    private let colon2 = UILabel() // second colon
    private let colon3 = UILabel() // third colon
    
    private lazy var timerArrayLabels = [daysLabel,colon1,hoursLabel,colon2,minutesLabel,colon3,secondsLabel]
    
    private var timerStackView = UIStackView()
    
    private var fourthLabel = UILabel() // text: Hundreds of songs in your pocket
    
    //Active offer button
    private var activeButton = UIButton()
    private var shadowView = UIView()
    
    //Bottom labels
    private var privacyLabel = UILabel() // text: Privacy
    private var restoreLabel = UILabel() // text: Restore
    private var termsLabel = UILabel() // text: Terms
    
    private var bottomLabelsStackView = UIStackView()
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black

        setupView()
        setUIElements()
        
    }
    
    //MARK: - View Did Layout Subviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupFrame()
  
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerCounter),
                                     userInfo: nil,
                                     repeats: true)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //MARK: - Timer selector
    @objc func timerCounter() {
        
        guard TimerViewContoller.secondsInDay != 0 else {
            timer.invalidate()
            activeButton.isEnabled = false
            return
            
        }
        
        TimerViewContoller.secondsInDay -= 1
        let time = secondsToDHMS(seconds: TimerViewContoller.secondsInDay)
                
        animateChangeTime(label: daysLabel, time: time.0)
        animateChangeTime(label: hoursLabel, time: time.1)
        animateChangeTime(label: minutesLabel, time: time.2)
        animateChangeTime(label: secondsLabel, time: time.3)
        

    }
    
    //MARK: - Active button action
    @objc func buttonActiveOfferAction() {
        timer.invalidate()
        let popView = PopView(frame: .zero, time: stopedTime()) //create pop view
        self.view.addSubview(popView) //show pop view
    }
    
    //convert second to days,hours,minutes,seeconds
    private func secondsToDHMS(seconds: Int) -> (Int,Int,Int,Int) {
        return (seconds / (3600 * 24), (seconds / 3600), (seconds % 3600) / 60 ,(seconds % 3600) % 60)
    }
    
    //animate time changing
    private func animateChangeTime(label: UILabel, time: Int) {
        if label.text !=  String(format: "%02d", time) {
            UIView.transition(with: label,
                              duration: 0.9,
                              options: .transitionCurlUp,
                              animations: {
                                    label.text = String(format: "%02d", time)
                    }, completion: nil)
        }
    }
    
    //Get time when ActiveButton tapped
    private func stopedTime() -> String {
        var time = ""
        if daysLabel.text != "00" {
            time += "01:00:00:00"
        } else {
            guard hoursLabel.text == "00"  else { time += hoursLabel.text! + ":" + minutesLabel.text! + ":" + secondsLabel.text!; return time }
            guard minutesLabel.text == "00" else { time += minutesLabel.text! + ":" + secondsLabel.text!; return time }
            guard secondLabel.text == "00" else { time += secondsLabel.text!; return time }
        }
        return time
    }

    //MARK: - setting UI elements
    private func setUIElements() {
        //image
        guard let image = UIImage(named: "musicImage") else { return }
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        //first label
        guard let firstLabelFont = UIFont(name: ".AppleSystemUIFontDemi", size: getSizeOrInsets(point: 22)) else { return }
        let firstLabelText = "LAST-MINUTE CHANCE!\nto claim your offer"
        firstLabel.setupLabel(font: firstLabelFont, numberOflines: 2, text: firstLabelText, color: .white)
        
        //second label
        guard let secondLabelFont = UIFont(name: ".AppleSystemUIFontBlack", size: getSizeOrInsets(point: 55)) else { return }
        let secondLabelText = "90% OFF"
        secondLabel.setupLabel(font: secondLabelFont, numberOflines: 1, text: secondLabelText, color: .white)
        
        //third label
        guard let thirdLabelFont = UIFont(name: ".AppleSystemUIFontDemi", size: getSizeOrInsets(point: 15)) else { return }
        let thirdLabelText = "For true music fans"
        thirdLabel.setupLabel(font: thirdLabelFont, numberOflines: 1, text: thirdLabelText, color: .white)
        
        //third label
        guard let fourthLabelFont = UIFont(name: ".AppleSystemUIFont", size: getSizeOrInsets(point: 17)) else { return }
        let fourthLabelText = "Hundreds of songs in your pocket"
        fourthLabel.setupLabel(font: fourthLabelFont, numberOflines: 1, text: fourthLabelText, color: .systemGray)
        
        //active button
        activeButton.setupActivateOfferButton(size: getSizeOrInsets(point: 15))
        
        //bottom labels
        let privacyLabelText = "Privacy"
        let restoreLabelText = "Restore"
        let termsLabelText = "Terms"
        privacyLabel.setupBottomLabel(text: privacyLabelText, size: getSizeOrInsets(point: 13))
        restoreLabel.setupBottomLabel(text: restoreLabelText, size: getSizeOrInsets(point: 13))
        termsLabel.setupBottomLabel(text: termsLabelText, size: getSizeOrInsets(point: 13))
        
        activeButton.addTarget(self, action: #selector(buttonActiveOfferAction), for: .touchUpInside)
        
        if deviceIdiom == .pad {
            firstLabel.font = UIFont(name: ".AppleSystemUIFontDemi", size: 40.0)!
            secondLabel.font = UIFont(name: ".AppleSystemUIFontBlack", size: 90.0)!
            thirdLabel.font = UIFont(name: ".AppleSystemUIFontDemi", size: 25.0)!
            fourthLabel.font = UIFont(name: ".AppleSystemUIFont", size: 23.0)
            activeButton.titleLabel?.font = UIFont(name:".AppleSystemUIFontDemi", size:40.0)

            [colon1,colon2,colon3].forEach({ $0.font = UIFont(name: ".AppleSystemUIFontEmphasized", size: 40.0) })

            [daysLabel,hoursLabel,minutesLabel,secondsLabel].forEach({ $0.font = UIFont(name: ".AppleSystemUIFontEmphasized", size: 40.0) })

            [privacyLabel, restoreLabel, termsLabel].forEach({ $0.font = UIFont(name: ".AppleSystemUIFont", size: 20.0)})

        }
    }
    
    //MARK: - Setup view
    private func setupView() {
        
        view.addSubview(imageView)
        
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(thirdLabel)
        
        [colon1,colon2,colon3].forEach({ $0.setupColonLabel(size: getSizeOrInsets(point: 15)) })
        
        [daysLabel,hoursLabel,minutesLabel,secondsLabel].forEach({ $0.setupTimerLabel(size: getSizeOrInsets(point: 15)) })
        
        daysLabel.text = String(format: "%02d", 1)
        
        timerStackView = UIStackView(arrangedSubviews: timerArrayLabels,
                                axis: .horizontal,
                                spacing: 0,
                                distribution: .equalSpacing,
                                mask: true)
        
        timerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(timerStackView)
        
        view.addSubview(fourthLabel)
        view.addSubview(shadowView)
        view.addSubview(activeButton)
        
        bottomLabelsStackView = UIStackView(arrangedSubviews: [privacyLabel, restoreLabel, termsLabel],
                                            axis: .horizontal,
                                            spacing: 0,
                                            distribution: .fillProportionally,
                                            mask: true)
        
        view.addSubview(bottomLabelsStackView)
        
        
    }
    
    //MARK: - Setup frame and constraints
    private func setupFrame() {
        
        //image
        imageView.frame = CGRect(x: 0, y: 0,
                                 width: screen.safeAreaWidth/2 - 30,
                                 height: screen.safeAreaWidth/2 / getImageSizeProportions(image: "musicImage"))
        imageView.center = CGPoint(x: screen.safeAreaWidth/4 + screen.leftInset - 15, y: screen.safeAreaHeight/2)

        let centerX = screen.leftInset + screen.safeAreaWidth*3/4 - 20
        
        let labelsWidth: CGFloat = screen.safeAreaWidth/2 - 20
        
        //first label
        
        var firstLabelYPos = firstLabel.frame.height/2 + getSizeOrInsets(point: 15)
        
        firstLabelYPos = deviceIdiom == .pad ? firstLabelYPos + Screen.shared.height * 0.15 : firstLabelYPos
        
        firstLabel.frame = CGRect(x: 0, y: 0,
                                  width: labelsWidth,
                                  height: firstLabel.font.pointSize * CGFloat(firstLabel.numberOfLines))
        
        firstLabel.center = CGPoint(x: centerX,
                                    y: firstLabelYPos)
        
        //second label
        secondLabel.frame = CGRect(x: 0, y: 0,
                                   width: labelsWidth,
                                   height: secondLabel.font.pointSize * CGFloat(secondLabel.numberOfLines))
        secondLabel.center = CGPoint(x: centerX,
                                     y: firstLabel.frame.maxY + getSizeOrInsets(point: 12) + secondLabel.frame.height/2)
        
        //third label
        thirdLabel.frame = CGRect(x: 0, y: 0,
                                  width: labelsWidth,
                                  height: thirdLabel.font.pointSize * CGFloat(thirdLabel.numberOfLines) + 5)
        thirdLabel.center = CGPoint(x: centerX,
                                    y: secondLabel.frame.maxY + getSizeOrInsets(point: 8) + thirdLabel.frame.height/2)
        
        //TIMER
        let stackViewWidth = labelsWidth - 20
        let stackViewHeight = getSizeOrInsets(point: 41)
        
        NSLayoutConstraint.activate([
            timerStackView.widthAnchor.constraint(equalToConstant: stackViewWidth),
            timerStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            timerStackView.topAnchor.constraint(equalTo: thirdLabel.bottomAnchor, constant: 20),
            timerStackView.centerXAnchor.constraint(equalTo: thirdLabel.centerXAnchor)
        ])
        
        
        let timeLabelWidht = stackViewWidth / 4.6
        let colonLabelWidth = (stackViewWidth - timeLabelWidht*4) / 3

        NSLayoutConstraint.activate([
            daysLabel.leadingAnchor.constraint(equalTo: timerStackView.leadingAnchor),
            daysLabel.topAnchor.constraint(equalTo: timerStackView.topAnchor),
            daysLabel.widthAnchor.constraint(equalToConstant: timeLabelWidht),
            daysLabel.heightAnchor.constraint(equalToConstant: stackViewHeight),
            
            colon1.leadingAnchor.constraint(equalTo: daysLabel.trailingAnchor),
            colon1.topAnchor.constraint(equalTo: timerStackView.topAnchor),
            colon1.widthAnchor.constraint(equalToConstant: colonLabelWidth),
            colon1.heightAnchor.constraint(equalToConstant: stackViewHeight),
            
            hoursLabel.leadingAnchor.constraint(equalTo: colon1.trailingAnchor),
            hoursLabel.topAnchor.constraint(equalTo: timerStackView.topAnchor),
            hoursLabel.widthAnchor.constraint(equalToConstant: timeLabelWidht),
            hoursLabel.heightAnchor.constraint(equalToConstant: stackViewHeight),
            
            colon2.leadingAnchor.constraint(equalTo: hoursLabel.trailingAnchor),
            colon2.topAnchor.constraint(equalTo: timerStackView.topAnchor),
            colon2.widthAnchor.constraint(equalToConstant: colonLabelWidth),
            colon2.heightAnchor.constraint(equalToConstant: stackViewHeight),
            
            minutesLabel.leadingAnchor.constraint(equalTo: colon2.trailingAnchor),
            minutesLabel.topAnchor.constraint(equalTo: timerStackView.topAnchor),
            minutesLabel.widthAnchor.constraint(equalToConstant: timeLabelWidht),
            minutesLabel.heightAnchor.constraint(equalToConstant: stackViewHeight),
            
            colon3.leadingAnchor.constraint(equalTo: minutesLabel.trailingAnchor),
            colon3.topAnchor.constraint(equalTo: timerStackView.topAnchor),
            colon3.widthAnchor.constraint(equalToConstant: colonLabelWidth),
            colon3.heightAnchor.constraint(equalToConstant: stackViewHeight),
            
            secondsLabel.leadingAnchor.constraint(equalTo: colon3.trailingAnchor),
            secondsLabel.topAnchor.constraint(equalTo: timerStackView.topAnchor),
            secondsLabel.widthAnchor.constraint(equalToConstant: timeLabelWidht),
            secondsLabel.heightAnchor.constraint(equalToConstant: stackViewHeight)
        
        ])
        
        [daysLabel,hoursLabel,minutesLabel,secondsLabel].forEach({ $0.layer.cornerRadius = timerStackView.frame.height / 5 })
        
        //fouth label
        fourthLabel.frame = CGRect(x: 0, y: 0,
                                  width: labelsWidth,
                                  height: fourthLabel.font.pointSize * CGFloat(fourthLabel.numberOfLines))
        fourthLabel.center = CGPoint(x: centerX,
                                     y: timerStackView.frame.maxY + getSizeOrInsets(point: 16) + fourthLabel.frame.height/2)
        
        //active offer button
        activeButton.frame = CGRect(x: 0, y: 0,
                                    width: labelsWidth,
                                    height: getSizeOrInsets(point: 63))
        activeButton.center = CGPoint(x: centerX,
                                      y: fourthLabel.frame.maxY + getSizeOrInsets(point: 12) + activeButton.frame.height/2)
        
        activeButton.layer.cornerRadius = activeButton.frame.height/5
        
        //Button gradient
        activeButton.addGradientLayer()
        
        
        let shadowFrame = CGRect(origin: CGPoint(x: activeButton.frame.origin.x - 10,
                                                 y: activeButton.frame.origin.y - 10),
                                 size: CGSize(width: activeButton.frame.width + 20,
                                              height: activeButton.frame.height + 20))
    
        shadowView.setShadowForActiveOfferButton(roundetRect: shadowFrame,
                                                 cornerRadii: CGSize(width: activeButton.frame.height/6,
                                                                     height: activeButton.frame.height/6))
        
        //bottom labels
        bottomLabelsStackView.frame = CGRect(x: 0, y: 0,
                                             width: labelsWidth,
                                             height: privacyLabel.font.pointSize * CGFloat(privacyLabel.numberOfLines))
        bottomLabelsStackView.center = CGPoint(x: centerX,
                                               y: activeButton.frame.maxY + getSizeOrInsets(point: 15))
        
    }
    
    private func getSizeOrInsets(point: CGFloat) -> CGFloat {
        return Screen.shared.height * point / 390
    }
    
    // width : height imageView
    private func getImageSizeProportions(image name: String) -> CGFloat {
        guard let image = UIImage(named: name) else { return 1 }
        return image.size.width/image.size.height
    }
    
    // width : height timer
    private func getTimerSizeProportions() -> CGFloat {
        return 295/41 // 295 - width of timer, 41 - height (ex. from TT iPhone 13)
    }
    
    // width : height timer
    private func getButtonHeightProportions() -> CGFloat {
        return 63/300
    }

}
