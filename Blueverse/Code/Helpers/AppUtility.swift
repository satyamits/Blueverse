//
//  AppUtility.swift
//  Blueverse
//
//  Created by Ravindra Soni on 11/12/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//


import Foundation

struct AppUtility {
    
	static var appVersion: String {
        if let appVersion = Bundle.main
            .infoDictionary!["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return ""
	}
    
    static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "-"
    }
    
    static var appVersionDisplayName: String {
        return String(format: "Version: %@ (%@)", AppUtility.appVersion, AppUtility.build)
    }
    
    // FIXME: update environment naming convention
    static var appVersionWithEnv: String {
        #if DEBUG
        return String(format: "%@- D", self.appVersionDisplayName)
        #elseif QA
        return String(format: "%@- Q", self.appVersionDisplayName)
        #elseif STAGING
        return String(format: "%@- S", self.appVersionDisplayName)
        #elseif RELEASE
        return self.appVersionDisplayName
        #endif
    }
    
    static var appStoreURL: String {
        // FIXME: Add app id
        let appId = ""
        let absoluteString = String(format: "https://apps.apple.com/app/id%@", appId)
        let url = absoluteString.replacingOccurrences(of: " ", with: "").lowercased()
        return url
    }
}
