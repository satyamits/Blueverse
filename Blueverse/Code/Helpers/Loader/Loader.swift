//
//  Loader.swift
//  Blueverse
//
//  Created by Ravindra Soni on 11/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit
import MBProgressHUD
import ReactiveSwift
import ReactiveCocoa

class Loader {
	
	static func showAdded(to view: UIView, animated: Bool) {
		MBProgressHUD.showAdded(to: view, animated: animated)
	}

	static func hide(for view: UIView, animated: Bool) {
		MBProgressHUD.hide(for: view, animated: animated)
	}
}

extension UIViewController {
	
    func loader(show: Bool, animated: Bool = false) {
        if show {
            Loader.showAdded(to: self.view, animated: animated)
        } else {
            Loader.hide(for: self.view, animated: animated)
        }
    }
    
}

extension Reactive where Base: UIViewController {
    public var showLoader: BindingTarget<Bool> {
        return makeBindingTarget(action: { (view, showLoader) in
            view.loader(show: showLoader)
        })
    }
    
    func makeBindingTarget<U>(_ key: StaticString = #function,
                              action: @escaping (Base, U) -> Void) -> BindingTarget<U> {
        return BindingTarget(on: UIScheduler(), lifetime: lifetime) { [weak base = self.base] value in
            if let base = base {
                action(base, value)
            }
        }
    }
}
