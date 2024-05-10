//
//  VersionCheck.swift
//  Model
//
//  Created by Vaibhav Parmar on 18/04/20.
//  Copyright © 2020 Nickelfox. All rights reserved.
//

import Foundation
import FoxAPIKit
import JSONParsing

public typealias VersionCheckHandler = (_ type: UpdateType, _ releaseNotes: String?) -> Void

public enum UpdateType {
    case major
    case minor
    case patch
    case unavailable
}

final public class VersionCheck {
    
    private var version: String
    private var releaseNotes: String
    
    init(_ version: String, _ releaseNotes: String) {
        self.version = version
        self.releaseNotes = releaseNotes
    }
    
    public static func isUpdateAvailable(completion: @escaping VersionCheckHandler) {
        let bundleDictionary = Bundle.main.infoDictionary
        guard let bundleId = bundleDictionary?["CFBundleIdentifier"] as? String,
            let currentVersion = bundleDictionary?["CFBundleShortVersionString"] as? String else {
                completion(.unavailable, nil); return
        }
        
        let router = ModelRouter.versionCheck(bundleId)
        BlueverseAPIClient.shared.request(router) { (result: APIResult<VersionCheck>) in
            switch result {
            case .success(let lookup):
                if lookup.version.isEmpty { completion(.unavailable, nil); return }
                let storeVersion = lookup.version
                
                if storeVersion == DataModel.shared.skippedVersion {
                    completion(.unavailable, nil)
                    return
                }
                
                if VersionCheck.isStoreVersionNewer(currentVersion, storeVersion) {
                    completion(VersionCheck.parseUpdate(currentVersion, storeVersion),
                               lookup.releaseNotes)
                }
                completion(.unavailable, nil)
            case .failure(let error):
                print("Failed to check version. Error: \(error)")
                completion(.unavailable, nil)
            }
        }
        
    }
    
    static func isStoreVersionNewer(_ currentVersion: String, _ storeVersion: String) -> Bool {
        return currentVersion.compare(storeVersion, options: .numeric) == .orderedAscending
    }
    
    static func parseUpdate(_ currentVersion: String, _ storeVersion: String) -> UpdateType {
        let oldVersion = self.split(version: currentVersion)
        let newVersion = self.split(version: storeVersion)
        
        guard let newVersionFirst = newVersion.first,
            let oldVersionFirst = oldVersion.first else {
            return .unavailable
        }
        
        if newVersionFirst > oldVersionFirst {
            return .major
        } else if newVersion.count > 1 && (oldVersion.count <= 1 || newVersion[1] > oldVersion[1]) {
            return .minor
        } else if newVersion.count > 2 && (oldVersion.count <= 2 || newVersion[2] > oldVersion[2]) {
            return .patch
        } else {
            return .unavailable
        }

    }
    
    private static func split(version: String) -> [Int] {
        return version.lazy.split { $0 == "." }.map { String($0) }.map { Int($0) ?? 0 }
    }
}

extension VersionCheck: JSONParseable {
    
    public static func parse(_ json: JSON) throws -> VersionCheck {
        return try VersionCheck(json["results"].array?.first?["version"]^ ?? "",
                                json["results"].array?.first?["releaseNotes"]^ ?? "")
    }
    
}
