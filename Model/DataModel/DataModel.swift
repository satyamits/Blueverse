//
//  DataModel.swift
//  Model
//
//  Created by Vaibhav Parmar on 18/04/20.
//  Copyright © 2020 Nickelfox. All rights reserved.
//

import Foundation

private struct UserDefaultConfigKey {
    static let onboarded = "UserOnboardedKey"
    static let skippedVersion = "SkippedVersionKey"
}

public class DataModel {
    
    public static let shared = DataModel()
        
    @UserDefault(UserDefaultConfigKey.onboarded, false)
    public var userOnboarded: Bool
    
    @UserDefault(UserDefaultConfigKey.skippedVersion, "")
    public var skippedVersion: String
    
}

@propertyWrapper
public struct UserDefault<T> {
    
    let key: String
    let defaultValue: T
    
    init(_ key: String, _ defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        } set {
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}

extension UserDefault where T: ExpressibleByNilLiteral {
    init(_ key: String) {
        self.init(key, nil)
    }
}
