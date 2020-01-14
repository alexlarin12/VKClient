//
//  CircleImageView.swift
//  VKClient
//
//  Created by Alex Larin on 14.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    var circleView: UIImage? {
        didSet{
            circleImageView.image = circleView
        }
    }
    private var circleImageView: UIImageView!
    override func awakeFromNib() {
        super .awakeFromNib()
        
        circleImageView = UIImageView(frame: bounds)
        self.circleImageView.clipsToBounds = true
        
        addSubview(circleImageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.frame = bounds
        layer.cornerRadius = bounds.width/2
        circleImageView.layer.cornerRadius = bounds.width/2
    }

}
