//
//  User.swift
//  Model
//
//  Created by Satyam Singh on 10/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import JSONParsing

public final class User: JSONParseable {
    
    
    public var token: String
    public var isKycDone: Bool
    public var role: String
    
    public init(token: String, isKycDone: Bool, role: String) {
        self.token = token
        self.isKycDone = isKycDone
        self.role = role
    }
    
    public static func parse(_ json: JSON) throws -> User {
        return User(token: json["user"]["token"]^!, isKycDone: json["user"]["isKycDone"]^!, role: json["user"]["role"]^!
                    
        )
    }
}
