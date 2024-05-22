//
//  LoginPageController.swift
//  Blueverse
//
//  Created by Satyam Singh on 20/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

protocol LoginPageControllerProtocol: AnyObject {
    var email: String { get set }
    var password: String { get set }
    func login()
    func checkUserStatus()
    
}


class LoginPageController: UIViewController {
    
    weak var activeField: UITextField?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var hidePasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var privacyText: UILabel!
    @IBOutlet weak var termsText: UILabel!
    @IBOutlet weak var loginDescriptionText: UILabel!
    @IBOutlet weak var privacyStackView: UIStackView!
    @IBOutlet weak var tickButton: UIButton!
    @IBOutlet weak var checkButtonView: UIView!
    @IBOutlet weak var loginDescriptionView: UIView!
    @IBOutlet weak var loginButtonView: UIView!
    @IBOutlet weak var forgotPasswordText: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var loginTextFiledStack: UIStackView!
    @IBOutlet weak var loginDataView: UIView!
    @IBOutlet weak var enterCredentialstext: UILabel!
    @IBOutlet weak var bluverseLogo: UIImageView!
    @IBOutlet weak var enterPasswordLogoView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginFormatView: UIView!
    @IBOutlet weak var bluverseimage: UIImageView!
    
    var viewModel: LoginPageControllerProtocol!
    
    
    var isChecked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTextFields()
        self.viewModel = LoginViewModel(self)
        //        self.tickButtonConfig()
        self.hidePasswordButtonConfig()
        //        self.updateLoginButtonState()
        loginButton.setTitleColor(.white, for: .normal)
        self.configureLoginUI()
        self.setupDismissKeyboardGesture()
        self.viewModel.checkUserStatus()
        

        NotificationCenter.default.addObserver(self, selector: #selector(LoginPageController.keyboardDidShow),
                    name: UIResponder.keyboardDidShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(LoginPageController.keyboardWillBeHidden),
                    name: UIResponder.keyboardWillHideNotification, object: nil)
//        self.showAlert(title: title, message: Sti)
        
    }
    
    //MARK: Handle KeyBoard
    
    deinit {
            NotificationCenter.default.removeObserver(self)
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            activeField = textField
        }
        
        @objc func keyboardDidShow(notification: Notification) {
            let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            guard let activeField = activeField, let keyboardHeight = keyboardSize?.height else { return }

            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            let activeRect = activeField.convert(activeField.bounds, to: scrollView)
            scrollView.scrollRectToVisible(activeRect, animated: true)
        }
        
        @objc func keyboardWillBeHidden(notification: Notification) {
            let contentInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    
    // MARK: TextFieldInitializer
    func initTextFields() {
        self.emailIdTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    // MARK: NavigationInstantisation
    func navigateToWallet(authToken: String) {
        let vc = UIStoryboard.init(name: "Wallet", bundle: Bundle.main).instantiateViewController(withIdentifier: "WalletViewController") as? WalletViewController
        print(authToken)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // MARK: LoginButtonIBAction
    
    @IBAction func loginButton(_ sender: UIButton) {
        viewModel.login()
    }
    
    // MARK: CheckButtonConfiguration
    
    
    @objc func tickButtonTapped() {
        if tickButton.currentImage == UIImage(named: "blankcheck") {
            tickButton.setImage(UIImage(named: "check"), for: .normal)
            loginButton.backgroundColor = UIColor.init(hex: "#1F59AF")
        } else {
            tickButton.setImage(UIImage(named: "blankcheck"), for: .normal)
            
            loginButton.backgroundColor = UIColor.init(hex: "#B3BBC7")
        }
    }
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        isChecked.toggle()
        tickButton.setImage(UIImage(named: isChecked ? "check" : "blankcheck" ), for: .normal)
        loginButton.backgroundColor = UIColor.init(hex: isChecked ?  "#1F59AF" : "#B3BBC7" )
        
    }
    
    
    func hidePasswordButtonConfig() {
        self.hidePasswordButton.setTitle("", for: .normal)
        self.hidePasswordButton.setImage(UIImage(named: "hideEyeIcon"), for: .normal)
        self.hidePasswordButton.addTarget(self, action: #selector(hidePasswordButtonTapped), for: .touchUpInside)
    }
    
    @objc func hidePasswordButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "hideEyeIcon" : "showPassword"
        hidePasswordButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyBoard() {
        
        view.endEditing(true)
    }
}

// MARK: UITextFieldDelegate

extension LoginPageController: UITextFieldDelegate {
    
    // MARK: SettingTheTextToEmailAndPassword
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == emailIdTextField {
            viewModel?.email = (textField.text) ?? ""
        } else if textField == passwordTextField {
            viewModel?.password = textField.text ?? ""
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
        if textField == emailIdTextField {
            if let email = emailIdTextField.text, email.isValidEmail {
                emailIdTextField.borderColor = UIColor(hex: "#C9D8EF")
            } else {
                emailIdTextField.borderColor = UIColor(hex: "#FF4049")
            }
        }
    }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            if textField == emailIdTextField {
                textField.resignFirstResponder()
                passwordTextField.becomeFirstResponder()
            } else if textField == passwordTextField {
                textField.resignFirstResponder()
                loginButton.becomeFirstResponder()
            }
            return true
        }
        
        func updateLoginButtonState() {
            let isEmailEmpty = emailIdTextField.text?.isEmpty ?? true
            let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true
            let isTickButtonUnchecked = tickButton.currentImage == UIImage(named: "blankcheck")
            
            loginButton.isEnabled = !isEmailEmpty && !isPasswordEmpty && !isTickButtonUnchecked
            
            loginButton.backgroundColor = loginButton.isEnabled ? UIColor.init(hex: "#1F59AF") : UIColor.init(hex: "#B3BBC7")
            loginButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            updateLoginButtonState()
        }
        
        func configureLoginUI() {
            self.loginFormatView.layer.cornerRadius = 12
            self.loginButton.layer.cornerRadius = 8
        }
}

extension LoginPageController {
    
    func showAlert(title: String, message: String) {
          let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alertController.addAction(okAction)
          present(alertController, animated: true, completion: nil)
        }
}


// MARK: LoginViewModelProtocol
extension LoginPageController: LoginViewModelProtocol {
    var email: String {
        return self.viewModel.email
    }
    
    var password: String {
        
        return self.viewModel.password
        
    }
    
}
