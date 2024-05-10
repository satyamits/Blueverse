//
//  HalfModalTransition.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import UIKit

class HalfModalTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    var viewController: UIViewController
    var presentingViewController: UIViewController
    var interactionController: HalfModalInteractiveTransition
    
    var interactiveDismiss = true
    
    init(viewController: UIViewController,
         presentingViewController: UIViewController) {
        self.viewController = viewController
        self.presentingViewController = presentingViewController
        self.interactionController = HalfModalInteractiveTransition(
            viewController: self.viewController,
            withView: self.presentingViewController.view,
            presentingViewController: self.presentingViewController
        )
        super.init()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        interactiveDismiss = false
        return HalfModalTransitionAnimator(type: .dismiss)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if interactiveDismiss {
            return self.interactionController
        }
        
        return nil
    }
    
}
