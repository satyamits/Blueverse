//
//  LocalNotificationManager.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationManager {
    
    static let shared = LocalNotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    private let content = UNMutableNotificationContent()
    
    func setupNotification(ofType type: LocalNotificationType) {
        self.removePendingNotifications()
        self.scheduleNotification(title: type.title,
                                  body: type.body,
                                  badge: type.badge,
                                  identifier: type.identifier,
                                  userInfo: type.userInfo,
                                  seconds: type.triggerInSeconds)
    }
    
    private func scheduleNotification(title: String,
                                      body: String,
                                      badge: NSNumber,
                                      identifier: String,
                                      userInfo: [String: Any],
                                      seconds: Int) {
        self.content.title = title
        self.content.body = body
        self.content.badge = badge
        self.content.userInfo = userInfo
        
        let timeInterval = TimeInterval(seconds)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: identifier,
                                            content: self.content,
                                            trigger: trigger)
        self.notificationCenter.add(request, withCompletionHandler: nil)
    }
    
    func removePendingNotifications() {
        self.notificationCenter.removeAllPendingNotificationRequests()
        self.notificationCenter.removeAllDeliveredNotifications()
    }
}
