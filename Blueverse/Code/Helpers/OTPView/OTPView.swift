//
//  OTPView.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import UIKit

protocol OTPViewDelegate: AnyObject {
    func otpViewAddText(_ text: String, at position: Int)
    func otpViewRemoveText(_ text: String, at position: Int)
    func otpViewChangePositionAt(_ position: Int)
    func otpViewBecomeFirstResponder()
    func otpViewResignFirstResponder()
}

@IBDesignable class OTPView: UIView {
    
    /** The number of textField that will be put in the OTPView */
    @IBInspectable var count: Int = 4

    /** Spacing between textField in the OTPView */
    @IBInspectable var spacing: CGFloat = 8

    /** Text color for the textField */
    @IBInspectable var textColor: UIColor = .black

    /** Text font for the textField */
    @IBInspectable var textFieldFont: UIFont = .systemFont(ofSize: 25)

    /** Placeholder */
    @IBInspectable var placeholder: String = ""

    /** Placeholder text color for the textField */
    @IBInspectable var placeholderTextColor: UIColor = UIColor.gray

    /** Circle textField */
    @IBInspectable var isCircleTextField: Bool = false

    /** Allow only Bottom Line for the TextField */
    @IBInspectable var isBottomLineTextField: Bool = false

    /** Background color for the textField */
    @IBInspectable var backGroundColorTextField: UIColor = UIColor.clear

    /** Border color for the TextField */
    @IBInspectable var borderColorTextField: UIColor?

    /** Border color for the TextField */
    @IBInspectable var selectedBorderColorTextField: UIColor?

    /** Border width for the TextField */
    @IBInspectable var borderWidthTextField: CGFloat = 0.0

    /** Border width for the TextField */
    @IBInspectable var selectedBorderWidthTextField: CGFloat = 0.0

    /** Corner radius for the TextField */
    @IBInspectable var cornerRadiusTextField: CGFloat = 0.0

    /** Tint/cursor color for the TextField */
    @IBInspectable var tintColorTextField: UIColor = .systemBlue
    
    /** input color for the TextField */
    @IBInspectable var selectedBorderColour: UIColor = .systemBlue
    
    /** error color for the TextField */
    @IBInspectable var errorBorderColour: UIColor = .red

    /** Shadow Radius for the TextField */
    @IBInspectable var shadowRadiusTextField: CGFloat = 0.0

    /** Shadow Opacity for the TextField */
    @IBInspectable var shadowOpacityTextField: Float = 0.0

    /** Shadow Offset Size for the TextField */
    @IBInspectable var shadowOffsetSizeTextField: CGSize = .zero

    /** Shadow color for the TextField */
    @IBInspectable var shadowColorTextField: UIColor?

    /** Dismiss keyboard with enter last character*/
    @IBInspectable var dismissOnLastEntry: Bool = false

    /** Secure Text Entry*/
    @IBInspectable var isSecureTextEntry: Bool = false

    /** Hide cursor*/
    @IBInspectable var isCursorHidden: Bool = false

    /** Dark keyboard*/
    @IBInspectable var isDarkKeyboard: Bool = false

    var textEdgeInsets: UIEdgeInsets?
    var editingTextEdgeInsets: UIEdgeInsets?

    weak var otpViewDelegate: OTPViewDelegate?
    var keyboardType: UIKeyboardType = .asciiCapableNumberPad

    var text: String? {
        get {
            var str = ""
            self.textFields.forEach { str.append($0.text ?? "") }
            return str
        } set {
            self.textFields.forEach {
                $0.text = nil
                $0.layer
                  .borderColor = borderColorTextField?.cgColor
            }
            for index in 0 ..< self.textFields.count where
            index < (newValue?.count ?? 0) {
                if let txt = newValue?[index..<index+1], let code = Int(txt) {
                    self.textFields[index].text = String(code)
                }
            }
        }
    }

    fileprivate var textFields: [OTPBackTextField] = []
    /** Override coder init, for IB/XIB compatibility */
    #if !TARGET_INTERFACE_BUILDER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /** Override common init, for manual allocation */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.initialization()
    }
    #endif

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.initialization()
    }

    func initialization() {
        if !self.textFields.isEmpty { return }
        let sizeTextField = (self.bounds.width/CGFloat(count)) - (spacing)
        
        for index in 1...count {
            let textField = OTPBackTextField()
            textField.delegate = self
            textField.otpBackDelegate = self
            textField.otpView = self
            textField.borderStyle = .none
            textField.tag = index * 1000
            textField.tintColor = tintColorTextField
            textField.layer.backgroundColor = backGroundColorTextField.cgColor
            textField.isSecureTextEntry = isSecureTextEntry
            textField.font = textFieldFont
            textField.keyboardAppearance = isDarkKeyboard ? .dark : .default
            if isCursorHidden { textField.tintColor = .clear }
            if isBottomLineTextField {
                let border = CALayer()
                border.name = "bottomBorderLayer"
                textField.removePreviouslyAddedLayer(name: border.name ?? "")
                border.backgroundColor = borderColorTextField?.cgColor
                border.frame = CGRect(x: 0,
                                      y: sizeTextField - borderWidthTextField,
                                      width: sizeTextField,
                                      height: borderWidthTextField)
                textField.layer.addSublayer(border)
            } else {
                textField.layer.borderColor = borderColorTextField?.cgColor
                textField.layer.borderWidth = borderWidthTextField
                if isCircleTextField {
                    textField.layer.cornerRadius = sizeTextField / 2
                } else {
                    textField.layer.cornerRadius = cornerRadiusTextField
                }
            }
            textField.layer.shadowRadius = shadowRadiusTextField
            if let shadowColorTextField = shadowColorTextField {
                textField.layer.shadowColor = shadowColorTextField.cgColor
            }
            textField.layer.shadowOpacity = shadowOpacityTextField
            textField.layer.shadowOffset = shadowOffsetSizeTextField

            textField.textColor = textColor
            textField.textAlignment = .center
            textField.keyboardType = keyboardType

            if placeholder.count > index - 1 {
                textField.attributedPlaceholder = NSAttributedString(string: placeholder[index - 1],
                attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColor])
            }

            let xAxis = (CGFloat(index-1) * sizeTextField) + (CGFloat(index) * spacing/2) + (CGFloat(index-1) * spacing/2)
            let yAxis = (self.bounds.height - sizeTextField)/2

            textField.frame = CGRect(x: xAxis,
                                     y: yAxis,
                                     width: sizeTextField,
                                     height: sizeTextField)

            self.textFields.append(textField)
            self.addSubview(textField)
            if isCursorHidden {
                let tapView = UIView(frame: self.bounds)
                tapView.backgroundColor = .clear
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                tapView.addGestureRecognizer(tap)
                self.addSubview(tapView)
            }
        }
    }

    override func becomeFirstResponder() -> Bool {
        if isCursorHidden {
            for index in 0 ..< self.textFields.count {
                if self.textFields[index].text?.isEmpty ?? true {
                    _ = self.textFields[index].becomeFirstResponder()
                    break
                } else if (self.textFields.count - 1) == index {
                    _ = self.textFields[index].becomeFirstResponder()
                    break
                }
            }
        } else {
            _ = self.textFields[0].becomeFirstResponder()
        }
        self.otpViewDelegate?.otpViewBecomeFirstResponder()
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        self.textFields.forEach { (textField) in
            _ = textField.resignFirstResponder()
        }
        self.otpViewDelegate?.otpViewResignFirstResponder()
        return super.resignFirstResponder()
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        _ = self.becomeFirstResponder()
    }

    func validate() -> Bool {
        var isValid = true
        self.textFields.forEach { (textField) in
            if Int(textField.text ?? "") == nil {
                isValid = false
            }
        }
        return isValid
    }
    
    func secureToggle() {
        self.textFields.forEach { (textField) in
            textField.isSecureTextEntry = !textField.isSecureTextEntry
        }
    }
}

extension OTPView: UITextFieldDelegate,
                      OTPBackTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.otpViewDelegate?.otpViewChangePositionAt(textField.tag/1000 - 1)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty {
            textField.text = string
            if textField.tag < count*1000 {
                let next = textField.superview?.viewWithTag((textField.tag/1000 + 1)*1000)
                next?.becomeFirstResponder()
            } else if textField.tag == count*1000 && dismissOnLastEntry {
                textField.resignFirstResponder()
            }
        } else if string.isEmpty { // is backspace
            textField.text = ""
        }
        self.otpViewDelegate?.otpViewAddText(text ?? "", at: textField.tag/1000 - 1)
        return false
    }

    func textFieldDidDelete(_ textField: UITextField) {
        if textField.tag > 1000, let next = textField.superview?.viewWithTag((textField.tag/1000 - 1)*1000) as? UITextField {
            next.text = ""
            next.becomeFirstResponder()
            self.otpViewDelegate?.otpViewRemoveText(text ?? "", at: next.tag/1000 - 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            textField.layer.borderColor = borderColorTextField?.cgColor
        } else {
            textField.layer.borderColor = selectedBorderColour.cgColor
        }
    }
}

// MARK: Helper Methods
extension OTPView {
    
    public func errorInOTP() {
        self.textFields.forEach { (textField) in
            textField.layer.borderColor = errorBorderColour.cgColor
        }
    }
}
