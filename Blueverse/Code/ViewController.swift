//
//  ViewController.swift
//  Blueverse
//
//  Created by Ravindra Soni on 11/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit
import Model
import ReactiveSwift

class ViewController: UIViewController {
    let email = "vaibhaw.anand+1@nickelfox.com"
    let password = "Password@1"
    let app = "DEALER"
    var disposable = CompositeDisposable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchMachineAction.apply("0fdee607-b7bc-4bf0-8db9-55021059fc2c").start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let fetchMachineAction = Action {(id: String) -> SignalProducer<Machine, ModelError> in
        return Machine.fetchMachineResponse(id: id)
    }
    func setupObservers() {
        self.disposable += self.fetchMachineAction.values.observeValues({ [weak self] response in
            print(response)
        })
        self.disposable += self.fetchMachineAction.errors.observeValues({ [weak self] (error) in
            print(error)
        })
    }
    

    
//    func login(email: String, password: String, app: String, completion: @escaping (APIResult<User>) -> Void) {
//        User.login(email: email, password: password, app: app) { apiResult in
//            completion(apiResult)
//        }
//    }
//        
//    login(email: email, password: password, app: app) { result in
//        switch result {
//        case .success(let user):
//            print("Token:", user.token)
//        case .failure(let error):
//            print("Error:", error)
//        }
//    }
//    
}
