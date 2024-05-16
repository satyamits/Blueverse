//
//  WalletHistory.swift
//  Model
//
//  Created by Satyam Singh on 16/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing

public final class WalletHistory: JSONParseable {
    public var fiters: [Machine]
    public var dealerId: String
    
    
    init(fiters: [Machine], dealerId: String) {
        self.fiters = fiters
        self.dealerId = dealerId
    }
    
    public static func parse(_ json: JSON) throws -> WalletHistory {
        return try WalletHistory(fiters: json["filters"]^^, dealerId: json["dealerId"]^!)
    }
}
