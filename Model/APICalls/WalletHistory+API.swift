//
//  WalletHistory+API.swift
//  Model
//
//  Created by Satyam Singh on 16/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import ReactiveSwift
import FoxAPIKit


extension WalletHistory {
    
    public static func fetchWalletResponse(params: [String: String]) -> SignalProducer<[WalletHistory], ModelError> {
        return SignalProducer { (signal, _) in
            let router = WalletHistoryRouter.fetchMachineBalances(params: params)
            BlueverseAPIClient.shared.request(router) { (result: APIResult<ListResponse<WalletHistory>>) in
                switch result {
                case .success(let response):
                    signal.send(value: response.list)
                    signal.sendCompleted()
                case .failure(let error):
                    signal.send(error: .customError(error: error))
                }
            }
        }
    }

}
