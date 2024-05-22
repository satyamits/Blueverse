//
//  LoginViewModel.swift
//  Blueverse
//
//  Created by Satyam Singh on 20/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import ReactiveSwift
import Model

protocol LoginViewModelProtocol: AnyObject {
    var email: String { get }
    var password: String { get }
    func navigateToWallet(authToken: String)
//    func showAlert(title: String, message: String)
}

class LoginViewModel {
    
    var email: String = ""
    var password: String = ""
    var app = "DEALER"
    var disposable = CompositeDisposable([])
    
    weak var view: LoginViewModelProtocol?
    
    let loginAction = Action {(email: String, password: String, app: String) -> SignalProducer<Bool, ModelError> in
        return User.login(email, password, app)
    }
    
    init(_ view: LoginViewModelProtocol?) {
        self.view = view
    }
    
    func setupObservers() {
    self.disposable += self.loginAction.values.observeValues({ [weak self] response in
    print(response)
    })
    self.disposable += self.loginAction.errors.observeValues({ [weak self] (error) in
    print(error)
    })
    }
    
    
    
    func login() {

        self.disposable += self.loginAction.apply((self.email,
                                                   self.password,
                                                   self.app)).startWithResult { [weak self] result in
            switch result {
            case .success:
                let authToken = DataModel.shared.authToken
                if authToken.isEmpty {
                    print("Auth token not found")
                    return
                }
                self?.view?.navigateToWallet(authToken: authToken)
                print("Logged in successfully")
            case .failure(let error):
                print("Login failed with error: \(error)")
//                showAlert(title: "Password Mismatch", message: "The passwords you entered do not match. Please try again.")
//                return
            }
        }
    }
    
    func checkUserStatus() {
        
        let userOnboarded = DataModel.shared.userOnboarded
        let authToken = DataModel.shared.authToken
        if userOnboarded && !authToken.isEmpty {
            self.view?.navigateToWallet(authToken: authToken)
        }
    }
    
}


extension LoginViewModel: LoginPageControllerProtocol {
    func navigateToWallet(authToken: String) {
        print("navigateToWallet called.")
    }
    
}
