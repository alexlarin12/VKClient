//
//  LoginViewController.swift
//  VKClient
//
//  Created by Alex Larin on 31.05.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var LetsGoButton: UIButton!
    @IBOutlet weak var AppContactLabel: UILabel!
    
    @IBOutlet weak var CupImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
              self.animateFieldsAppearing()
              self.animateCupImageAppearing()
              self.animateTitlesAppearing()
      
        
    }
    //метод "чашка падает и пружинит":
    func animateCupImageAppearing() {
        self.CupImageView.transform = CGAffineTransform(translationX: 0,y: -self.view.bounds.height/2)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.CupImageView.transform = .identity
        },
                       completion: nil)
    }
    //метод "постепенное появление цвета Button и Label":
    func animateFieldsAppearing() {
           let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
           fadeInAnimation.fromValue = 0
           fadeInAnimation.toValue = 1
           fadeInAnimation.duration = 1
           fadeInAnimation.beginTime = CACurrentMediaTime() + 1
           fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
           fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
           
           self.AppContactLabel.layer.add(fadeInAnimation, forKey: nil)
           self.LetsGoButton.layer.add(fadeInAnimation, forKey: nil)
       }
    
    //метод "Button и Label появляются с разных сторон":
    func animateTitlesAppearing() {
        let offset = view.bounds.width
        AppContactLabel.transform = CGAffineTransform(translationX: -offset, y: 0)
        LetsGoButton.transform = CGAffineTransform(translationX: offset, y: 0)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.AppContactLabel.transform = .identity
                        self.LetsGoButton.transform = .identity
        },
                       completion: nil)
    }
    
}
