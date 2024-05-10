//
//  OTPTextField.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import UIKit

protocol OTPBackTextFieldDelegate: AnyObject {
    func textFieldDidDelete(_ textField: UITextField)
}


class OTPBackTextField: UITextField {
    weak var otpBackDelegate: OTPBackTextFieldDelegate?
    weak var otpView: OTPView!

    override func deleteBackward() {
        super.deleteBackward()
        otpBackDelegate?.textFieldDidDelete(self)
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

    override func becomeFirstResponder() -> Bool {
        self.addSelectedBorderColor()
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        self.addUnselectedBorderColor()
        return super.resignFirstResponder()
    }

    fileprivate func addSelectedBorderColor() {
        if let selectedBorderColor = self.otpView.selectedBorderColorTextField {
            if self.otpView.isBottomLineTextField {
                self.addBottomLine(selectedBorderColor, width: self.otpView.selectedBorderWidthTextField)
            } else {
                layer.borderColor = selectedBorderColor.cgColor
                layer.borderWidth = self.otpView.selectedBorderWidthTextField
            }
        } else {
            if self.otpView.isBottomLineTextField {
                self.removePreviouslyAddedLayer(name: "bottomBorderLayer")
            } else {
                layer.borderColor = nil
                layer.borderWidth = 0
            }
        }
    }

    fileprivate func addUnselectedBorderColor() {
        if let unselectedBorderColor = self.otpView.borderColorTextField {
            if self.otpView.isBottomLineTextField {
                self.addBottomLine(unselectedBorderColor, width: self.otpView.borderWidthTextField)
            } else {
                layer.borderColor = unselectedBorderColor.cgColor
                layer.borderWidth = self.otpView.borderWidthTextField
            }
        } else {
            if self.otpView.isBottomLineTextField {
                self.removePreviouslyAddedLayer(name: "bottomBorderLayer")
            } else {
                layer.borderColor = nil
                layer.borderWidth = 0
            }
        }
    }

    fileprivate func addBottomLine(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "bottomBorderLayer"
        self.removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.width - width,
                              width: self.frame.width, height: width)
        self.layer.addSublayer(border)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.otpView.textEdgeInsets ?? UIEdgeInsets.zero)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.otpView.editingTextEdgeInsets ?? UIEdgeInsets.zero)
    }

    func removePreviouslyAddedLayer(name: String) {
        if self.layer.sublayers?.count ?? 0 > 0 {
            self.layer.sublayers?.forEach {
                if $0.name == name {
                    $0.removeFromSuperlayer()
                }
            }
        }
    }
}
