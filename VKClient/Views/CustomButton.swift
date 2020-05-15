//
//  CustomButton.swift
//  VKClient
//
//  Created by Alex Larin on 30.04.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit
class CustomButton: UIButton {

    var color: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    let touchDownAlpha: CGFloat = 0.3

    func setup() {
        backgroundColor = .gray
        layer.backgroundColor = color.cgColor
        layer.cornerRadius = 6
        clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        if let backgroundColor = backgroundColor {
            color = backgroundColor
        }

        setup()
    }
    convenience init(color: UIColor? = nil, title: String? = nil) {
        self.init(type: .custom)

        if let color = color {
            self.color = color
        }

        if let title = title {
            setTitle(title, for: .normal)
        }

        setup()
    }
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                touchDown()
            } else {
                cancelTracking(with: nil)
                touchUp()
            }
        }
    }

    
    func touchDown() {
        stopTimer()

        layer.backgroundColor = color.withAlphaComponent(touchDownAlpha).cgColor
    }
    let timerStep: TimeInterval = 0.01
    let animateTime: TimeInterval = 0.4
    lazy var alphaStep: CGFloat = {
        return (1 - touchDownAlpha) / CGFloat(animateTime / timerStep)
    }()
    
    func touchUp() {
        timer = Timer.scheduledTimer(timeInterval: timerStep,
        target: self,
        selector: #selector(animation),
        userInfo: nil,
        repeats: true)
    }
    weak var timer: Timer?

    func stopTimer() {
        timer?.invalidate()
    }

    deinit {
        stopTimer()
    }
    @objc func animation() {
        guard let backgroundAlpha = layer.backgroundColor?.alpha else {
            stopTimer()

            return
        }

        let newAlpha = backgroundAlpha + alphaStep

        if newAlpha < 1 {
            layer.backgroundColor = color.withAlphaComponent(newAlpha).cgColor
        } else {
            layer.backgroundColor = color.cgColor

            stopTimer()
        }
    }
    
}
