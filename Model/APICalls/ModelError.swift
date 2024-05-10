//
//  ModelError.swift
//  Model
//
//  Created by Satyam Singh on 10/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import AnyErrorKit


public enum ModelError: AnyError {
  case userNotLoggedIn
  case authTokenNil
  case custom(message: String)
  case sessionExpired(statusCode: Int)
  case customError(error: AnyError)
    
  public var code: Int {
    switch self {
    case .userNotLoggedIn,
       .custom,
       .authTokenNil:
      return 0
    case .sessionExpired(let statusCode):
      return statusCode
    case .customError(let error):
      return error.code
    }
  }
    
    
    public var domain: String { return "Model Error" }
    
  public var message: String {
    switch self {
    case .userNotLoggedIn:
      return "User not loggedIn"
    case .authTokenNil:
        return "Auth Token is nil"
    case .sessionExpired:
      return "Session Expired!! Please Re-Login"
    case .custom(let message):
      return message
    case .customError(let error):
      return error.message
    }
  }
  public var title: String {
    return "Error"
  }
}
