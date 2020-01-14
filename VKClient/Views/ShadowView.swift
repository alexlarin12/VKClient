//
//  ShadowView.swift
//  VKClient
//
//  Created by Alex Larin on 11.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
  
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Drawing code
        self.layer.borderColor = #colorLiteral(red: 0.3654780984, green: 0.3364349902, blue: 0.3280779719, alpha: 1).cgColor
        self.layer.cornerRadius = bounds.width/2
        self.layer.borderWidth = 2
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 0.7
    }    

}
