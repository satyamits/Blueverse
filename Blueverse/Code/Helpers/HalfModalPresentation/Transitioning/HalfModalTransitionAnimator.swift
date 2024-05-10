//
//  HalfModalTransitionAnimator.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import UIKit

class HalfModalTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var type: HalfModalTransitionAnimatorType
    
    init(type: HalfModalTransitionAnimatorType) {
        self.type = type
    }
    
    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        _ = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration) {
            from.view.frame.origin.y = 800
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
}

internal enum HalfModalTransitionAnimatorType {
    case present
    case dismiss
}
