//
//  RootViewController.swift
//  Blueverse
//
//  Created by Satyam Singh on 14/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import SwiftUI
import Model
import ReactiveSwift

class RootViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    var navigationStack: [UIViewController] = []
    
    private let email = "vaibhaw.anand+1@nickelfox.com"
    private let password = "Password@1"
    private let app = "DEALER"
    var disposable = CompositeDisposable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.checkUserStatus()
        self.setupObservers()
    }
    
//    func checkUserStatus() {
//        if DataModel.shared.userOnboarded {
//            return navigateToWallet(authToken: authToken)
//        }
//        self.loginButton.isHidden = false
//    }

    
    let loginAction = Action {(email: String, password: String, app: String) -> SignalProducer<Bool, ModelError> in
        return User.login(email, password, app)
    }
    
    func navigateToWallet(authToken: String) {
        let vc = UIStoryboard.init(name: "Wallet", bundle: Bundle.main).instantiateViewController(withIdentifier: "WalletViewController") as? WalletViewController
        print(authToken)
        self.navigationController?.pushViewController(vc!, animated: true)
        }
    
    @IBAction func loginButton(_ sender: UIButton) {
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
                    self?.navigateToWallet(authToken: authToken)
                    print("Logged in successfully")
            case .failure(let error):
                print("Login failed with error: \(error)")
            }
        }
    }
    
    func setupObservers() {
        self.disposable += self.loginAction.values.observeValues({ [weak self] response in
            print(response)
        })
        self.disposable += self.loginAction.errors.observeValues({ [weak self] (error) in
            print(error)
        })
    }
    
}
