//
//  LikeButton.swift
//  VKClient
//
//  Created by Alex Larin on 14.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

    class LikeButtonRed: UIControl{
        var isLiked: Bool = false
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupView()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
            setupView()
        }
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            let sideOne = rect.height * 0.4
            let sideTwo = rect.height * 0.3
            let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
            let path = UIBezierPath()
            
            
            path.addArc(withCenter: CGPoint(x: rect.height * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians1, endAngle: 315.degreesToRadians1, clockwise: true)
            
            path.addArc(withCenter: CGPoint(x: rect.height * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians1, endAngle: 45.degreesToRadians1, clockwise: true)
            path.addLine(to: CGPoint(x: rect.height * 0.5, y: rect.height * 0.95))
            path.close()
            UIColor.white.setStroke()
            UIColor.red.setFill()
            isLiked ? path.fill() : path.stroke()
        }
        func setupView(){
            self.addTarget(self, action: #selector(changeState), for: .touchUpInside)
            self.backgroundColor = UIColor.clear
            self.layer.cornerRadius = min(self.bounds.height, self.bounds.width)/5
            clipsToBounds = true
            
        }
        @objc func valueDidChanged(){
            
        }
        
        @objc func changeState(){
            isLiked.toggle()
            self.sendActions(for: .valueChanged)
            setNeedsDisplay()
        }
    }
    extension Int {
        var degreesToRadians1: CGFloat { return CGFloat(self) * .pi / 180 }
    }
    
