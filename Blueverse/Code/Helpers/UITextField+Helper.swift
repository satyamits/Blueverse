//
//  UITextField+Helper.swift
//  Blueverse
//
//  Created by Ravindra Soni on 11/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//


import UIKit

extension UITextField {
    @IBInspectable var placeholderColor: UIColor? {
        get {
            return self.placeholderColor
        }
        set {
            guard let placeholder = self.placeholder,
                let placeholderColor = newValue else { return }
            let foregroundAttribute = [NSAttributedString.Key.foregroundColor: placeholderColor]
            self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                            attributes: foregroundAttribute)
        }
    }
}
