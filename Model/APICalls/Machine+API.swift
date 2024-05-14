//
//  Machine+API.swift
//  Model
//
//  Created by Satyam Singh on 10/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import ReactiveSwift

extension Machine {
    
    public static func fetchMachineResponse(id: String) -> SignalProducer<Machine, ModelError> {
        return SignalProducer { (signal, _) in
            let router = MachineRouter.fetchMachines(id: id)
            BlueverseAPIClient.shared.request(router) { (result: APIResult<Machine>) in
                switch result {
                case .success(let response):
                    signal.send(value: response)
                    signal.sendCompleted()
                case .failure(let error):
                    signal.send(error: .customError(error: error))
                }
            }
        }
    }
    
}
