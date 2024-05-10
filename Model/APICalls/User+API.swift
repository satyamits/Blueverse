//
//  User+API.swift
//  Model
//
//  Created by Satyam Singh on 10/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import AnyErrorKit
import JSONParsing

extension User {
    
    static public func login(email: String, password: String, app: String, completion: @escaping (APIResult<User>) -> Void) {
        let userRouter = UserRouter.login(email: email, password: password, app: app)
        FoxAPIClient.shared.request(userRouter, completion: completion)
    }
}
