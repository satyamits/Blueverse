//
//  LocalNotificationType.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import Foundation

enum LocalNotificationType {
    case demo(seconds: Int, id: String)
    
    var title: String {
        switch self {
        case .demo: return "This is demo Notification!"
        }
    }
    
    var body: String {
        switch self {
        case .demo:
            return "This is body of local notification."
        }
    }
    
    var badge: NSNumber {
        switch self {
        case .demo: return 0
        }
    }
    
    var identifier: String {
        switch self {
        case .demo: return "demo_notification"
        }
    }
    
    var userInfo: [String: Any] {
        switch self {
        case .demo(_, let id):
            return ["type_id": id,
                    "type": ""]
        }
    }
    
    var triggerInSeconds: Int {
        switch self {
        case .demo(let seconds, _):
            return seconds
        }
    }
}
