//
//  AuthHeaders.swift
//  Model
//
//  Created by Vaibhav Parmar on 18/04/20.
//  Copyright © 2020 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import JSONParsing
import SwiftyJSON
import Alamofire

public struct AuthHeaders: AuthHeadersProtocol {
    let authorizationToken: String?
    
    public static func parse(_ json: JSON) throws -> AuthHeaders {
        return try AuthHeaders(
            authorizationToken: json[authorizationTokenKey]^
        )
    }
    
    public func toJSON() -> [String: String] {
        let res: [String: String] = [
            authorizationTokenKey: self.authorizationToken ?? ""
        ]
        return res
    }
    
    public var isValid: Bool {
        return !(self.authorizationToken?.isEmpty ?? true)
    }
    
}

extension AuthHeaders {
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let token = self.authorizationToken {
            urlRequest.setValue("Token \(token)", forHTTPHeaderField: authorizationTokenKey)
        }
        return urlRequest
    }
}

private let authorizationTokenKey = "Authorization"
private let contentType = "Content-Type"
