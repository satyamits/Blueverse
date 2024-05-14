//
//  MachineRouter.swift
//  Model
//
//  Created by Satyam Singh on 10/05/24.
//  Copyright © 2024 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public enum MachineRouter: BaseRouter {
    case fetchMachines(id: String)
    
    public var method: HTTPMethod {
        switch self {
        case .fetchMachines:
             return .get
        }
    }
    public var path: String {
        switch self {
        case .fetchMachines(let id):
            return "/user/dealer/detail/\(id)"
        }
    }
    public var params: [String: Any] {
        switch self {
        default: return [:]
        }
    }
    public var keypathToMap: String? {
        switch self {
        default:
            return "data"
        }
    }
}
