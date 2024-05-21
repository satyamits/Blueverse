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
}

class LoginPageController: UIViewController {
    
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
        self.updateLoginButtonState()
        loginButton.setTitleColor(.white, for: .normal)
        
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
    
//    // MARK: CheckButtonConfiguration
//    func tickButtonConfig() {
//        self.tickButton.setImage(UIImage(named: "blankcheck"), for: .normal)
//        self.tickButton.addTarget(self, action: #selector(tickButtonTapped), for: .touchUpInside)
//        self.loginButton.setTitleColor(UIColor.white, for: .normal)
//    }
    
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
    
    func updateLoginButtonState() {
        let isEmailEmpty = emailIdTextField.text?.isEmpty ?? true
        let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true
        let isTickButtonUnchecked = tickButton.currentImage == UIImage(named: "blankcheck")
        
        loginButton.isEnabled = !isEmailEmpty && !isPasswordEmpty && !isTickButtonUnchecked
        
        loginButton.backgroundColor = loginButton.isEnabled ? UIColor.init(hex: "#1F59AF") : UIColor.init(hex: "#B3BBC7")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateLoginButtonState()
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
