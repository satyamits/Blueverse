//
//  FoxAPIClient.swift
//  Model
//
//  Created by Satyam Singh on 10/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import SwiftyJSON

class FoxAPIClient: APIClient<AuthHeaders, ErrorResponse> {
    static let shared = FoxAPIClient()
    override init() {
        super.init()
    }
    
    override func authenticationHeaders(response: HTTPURLResponse) -> AuthHeaders? {
        return try? AuthHeaders.parse(JSON(response.allHeaderFields))
    }
    
}
