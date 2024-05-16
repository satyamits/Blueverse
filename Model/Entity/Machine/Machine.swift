//
//  Machine.swift
//  Model
//
//  Created by Satyam Singh on 10/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing

public final class Outlets: JSONParseable {
    public var name: String
    public var address: String
    public var dealerId: String
    public var machines: [Machine]
    
    init(name: String, address: String, dealerId: String, machines: [Machine]) {
        self.name = name
        self.address = address
        self.dealerId = dealerId
        self.machines = machines
    }
    
    public static func parse(_ json: JSON) throws -> Outlets {
        return try Outlets(name: json["name"]^!,
                       address: json["address"]^!,
                       dealerId: json["dealerId"]^!,
                       machines: json["machines"]^^)
    }
    
}


public final class Machine: JSONParseable {
    public var name: String
    public var machineGuid: String
    public var status: String
    public var isAssigned: Bool
    public var walletBalance: Double
    public var blueverseCredit: Double
    public var feedbackFormId: String?
    
    init(name: String,
         machineGuid: String,
         status: String,
         isAssigned: Bool,
         feedbackFormId: String,
         walletbalance: Double,
         blueverseCredit: Double) {
        self.name = name
        self.machineGuid = machineGuid
        self.status = status
        self.isAssigned = isAssigned
        self.feedbackFormId = feedbackFormId
        self.walletBalance = walletbalance
        self.blueverseCredit = blueverseCredit
    }
    
    public static func parse(_ json: JSON) throws -> Machine {
        return  Machine(name: json["name"]^!,
                        machineGuid: json["machineGuid"]^!,
                        status: json["status"]^!,
                        isAssigned: json["isAssigned"]^!,
                        feedbackFormId: json["feedbackFormId"]^!,
                        walletbalance: json["walletBalance"]^!,
                        blueverseCredit: json["blueverseCredit"]^!)
    }
}
