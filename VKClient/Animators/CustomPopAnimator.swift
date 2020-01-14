//
//  CustomPopAnimator.swift
//  VKClient
//
//  Created by Alex Larin on 21.12.2019.
//  Copyright © 2019 Alex Larin. All rights reserved.
//

import UIKit

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.5
        }
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard let source = transitionContext.viewController(forKey: .from) else{return}
            guard let destination = transitionContext.viewController(forKey: .to) else{return}
            
            destination.view.frame = source.view.frame
            
            let transition = CGAffineTransform(translationX: -200, y: 0)
            transitionContext.containerView.addSubview(destination.view) 
            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
            destination.view.transform = transition.concatenating(scale)
            
            UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                    delay: 0,
                                    options: .calculationModePaced,
                                    animations: {
                                
                                   UIView.addKeyframe(withRelativeStartTime: 0,
                                                  relativeDuration: 0.4,
                                                  animations: {
                                                  let transition = CGAffineTransform(translationX: source.view.frame.width/2, y: 0)
                                                  let scale = CGAffineTransform(scaleX: 1.2, y: 1.2)
                                                  source.view.transform = transition.concatenating(scale)
                                    
                                   })
                                   UIView.addKeyframe(withRelativeStartTime: 0.4,
                                                  relativeDuration: 0.4,
                                                  animations: {
                                                  source.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
                                    
                                   })
                                   UIView.addKeyframe(withRelativeStartTime: 0.25,
                                                  relativeDuration: 0.75,
                                                  animations: {
                                                  destination.view.transform = .identity
                                   })
            }) {finished in
                if finished && !transitionContext.transitionWasCancelled{
                    source.removeFromParent()
                }else if transitionContext.transitionWasCancelled {
                    destination.view.transform = .identity
                }
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            }
        }
    }

    
    
    
    

