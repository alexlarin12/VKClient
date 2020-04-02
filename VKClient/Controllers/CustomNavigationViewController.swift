//
//  ViewController.swift
//  VKClient
//
//  Created by Alex Larin on 21.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController, UINavigationControllerDelegate {
    let interactiveTransition = CustomInteractiveTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            self.interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        }
        return nil
    }
}
