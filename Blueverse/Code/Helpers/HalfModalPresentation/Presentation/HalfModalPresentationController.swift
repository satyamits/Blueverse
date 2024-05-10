//
//  HalfModalPresentationController.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import UIKit

enum ModalScaleState {
    case adjustedOnce
    case normal
}

class HalfModalPresentationController: UIPresentationController {
    var isMaximized: Bool = false
    
    var mainDimmingView: UIView?
    var panGestureRecognizer: UIPanGestureRecognizer
    var direction: CGFloat = 0
    var state: ModalScaleState = .normal
    
    var dimmingView: UIView {
        if let dimmedView = mainDimmingView {
            return dimmedView
        }
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: containerView!.bounds.width, height: containerView!.bounds.height))
        
        // Blur Effect
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        
//        view.backgroundColor = Colors.themeBlack.withAlphaComponent(0.5)
        
        self.mainDimmingView = view
        
        return view
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        self.panGestureRecognizer = UIPanGestureRecognizer()
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        panGestureRecognizer.addTarget(self, action: #selector(onPan(pan:)))
        presentedViewController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func onPan(pan: UIPanGestureRecognizer) {
        let endPoint = pan.translation(in: pan.view?.superview)
        
        switch pan.state {
        case .began:
            presentedView!.frame.size.height = containerView!.frame.height
        case .changed:
            let velocity = pan.velocity(in: pan.view?.superview)
            switch state {
            case .normal:
                presentedView!.frame.origin.y = endPoint.y + containerView!.frame.height * 0.4
            case .adjustedOnce:
                presentedView!.frame.origin.y = endPoint.y
            }
            direction = velocity.y
            
        case .ended:
            if direction < 0 {
                changeScale(to: .adjustedOnce)
            } else {
                if state == .adjustedOnce {
                    changeScale(to: .normal)
                } else {
                    presentedViewController.dismiss(animated: true, completion: nil)
                }
            }
        default:
            break
        }
    }
    
    func changeScale(to state: ModalScaleState) {
        if let presentedView = presentedView, let containerView = self.containerView {
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.8,
                           options: .curveEaseInOut,
                           animations: { () -> Void in
                presentedView.frame = containerView.frame
                let containerFrame = containerView.frame
                let halfFrame = CGRect(x: 0,
                                       y: containerFrame.height * 0.4,
                                       width: containerFrame.width,
                                       height: containerFrame.height * 0.6)
                            
                let fullFrame = CGRect(x: 0,
                                       y: 50,
                                       width: containerFrame.width,
                                       height: containerFrame.height - 50)
                let frame = state == .adjustedOnce ? fullFrame : halfFrame
                
                presentedView.frame = frame
                
                if let navController = self.presentedViewController as? UINavigationController {
                    self.isMaximized = true
                    
                    navController.setNeedsStatusBarAppearanceUpdate()
                    
                    // Force the navigation bar to update its size
                    navController.isNavigationBarHidden = true
                    navController.isNavigationBarHidden = false
                }
            }, completion: { _ in
                self.state = state
            })
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0,
                      y: containerView!.bounds.height * 0.4,
                      width: containerView!.bounds.width,
                      height: containerView!.bounds.height * 0.6)
    }
    
    override func presentationTransitionWillBegin() {
        let dimmedView = dimmingView
        
        if let containerView = self.containerView, let coordinator = presentingViewController.transitionCoordinator {
            
            dimmedView.alpha = 0
            containerView.addSubview(dimmedView)
            dimmedView.addSubview(presentedViewController.view)
            
            coordinator.animate(alongsideTransition: { _ -> Void in
                dimmedView.alpha = 1
                self.presentingViewController
                    .view
                    .transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentingViewController.transitionCoordinator {
            
            coordinator.animate(alongsideTransition: { _ -> Void in
                self.dimmingView.alpha = 0
                self.presentingViewController.view.transform = CGAffineTransform.identity
            }, completion: { _ -> Void in
                print("done dismiss animation")
            })
            
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        print("dismissal did end: \(completed)")
        
        if completed {
            dimmingView.removeFromSuperview()
            mainDimmingView = nil
            
            isMaximized = false
        }
    }
}

protocol HalfModalPresentable { }

extension HalfModalPresentable where Self: UIViewController {
    func maximizeToFullScreenWithNavigation() {
        if let presentation = navigationController?.presentationController as? HalfModalPresentationController {
            presentation.changeScale(to: .adjustedOnce)
        }
    }
    
    func maximizeToFullScreenWithoutNavigation() {
        if let presentation = presentationController as? HalfModalPresentationController {
            presentation.changeScale(to: .adjustedOnce)
        }
    }
    
    func minimizeToHalfScreenWithoutNavigation() {
        if let presentation = presentationController as? HalfModalPresentationController {
            presentation.changeScale(to: .normal)
        }
    }
}

extension HalfModalPresentable where Self: UINavigationController {
    func isHalfModalMaximized() -> Bool {
        if let presentationController = presentationController as? HalfModalPresentationController {
            return presentationController.isMaximized
        }
        
        return false
    }
}
