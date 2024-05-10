//
//  FontHelper.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setFont(_ fontType: FontType) {
        self.font = AppFont.getFont(fontType)
    }
    
}

extension UIButton {
    
    func setFont(_ fontType: FontType) {
        self.titleLabel?.font = AppFont.getFont(fontType)
    }
    
}

extension UITextField {
    
    func setFont(_ fontType: FontType) {
        self.font = AppFont.getFont(fontType)
    }
    
}

extension UITextView {
    
    func setFont(_ fontType: FontType) {
        self.font = AppFont.getFont(fontType)
    }
    
}
