//
//  ModelRouter.swift
//  Model
//
//  Created by Vaibhav Parmar on 18/04/20.
//  Copyright © 2020 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit

public enum ModelRouter: BaseRouter {
    case versionCheck(_ bundleId: String)
        
    public var baseUrl: URL {
        switch self {
        case .versionCheck(let bundleId):
            return URL(string: APIConfig.appStoreLookup + bundleId)!
        }
    }
}
