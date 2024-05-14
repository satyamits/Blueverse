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
        self.checkUserStatus()
        self.setupObservers()
    }
    
    func checkUserStatus() {
        if DataModel.shared.userOnboarded {
            return
        }
        self.loginButton.isHidden = false
    }

    
    let loginAction = Action {(email: String, password: String, app: String) -> SignalProducer<Bool, ModelError> in
        return User.login(email, password, app)
    }
    
//    func navigateToWallet() {
//            let walletVC = WalletViewController()
//            navigationController?.pushViewController(walletVC, animated: true)
//        }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.disposable += self.loginAction.apply((self.email,
                                                   self.password,
                                                   self.app)).start()
        
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
