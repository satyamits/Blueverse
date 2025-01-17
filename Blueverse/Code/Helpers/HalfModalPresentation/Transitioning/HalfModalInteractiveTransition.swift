//
//  HalfModalInteractiveTransition.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import UIKit

class HalfModalInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var viewController: UIViewController
    var presentingViewController: UIViewController?
    var panGestureRecognizer: UIPanGestureRecognizer
    
    var shouldComplete: Bool = false
    
    init(viewController: UIViewController,
         withView view: UIView,
         presentingViewController: UIViewController?) {
        self.viewController = viewController
        self.presentingViewController = presentingViewController
        self.panGestureRecognizer = UIPanGestureRecognizer()
        
        super.init()
        
        self.panGestureRecognizer.addTarget(self, action: #selector(onPan))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        super.startInteractiveTransition(transitionContext)
    }
    
    override var completionSpeed: CGFloat {
        get {
            return 1.0 - self.percentComplete
        }
        set {}
    }
    
    @objc func onPan(pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: pan.view?.superview)
        
        switch pan.state {
        case .began:
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        case .changed:
            let screenHeight = UIScreen.main.bounds.size.height - 50
            let dragAmount = screenHeight
            let threshold: Float = 0.2
            var percent: Float = Float(translation.y) / Float(dragAmount)

            percent = fmaxf(percent, 0.0)
            percent = fminf(percent, 1.0)
            
            update(CGFloat(percent))
            
            shouldComplete = percent > threshold
        case .ended, .cancelled:
            if pan.state == .cancelled || !shouldComplete {
                cancel()
            } else {
                finish()
            }
        default:
            cancel()
        }
    }
}
