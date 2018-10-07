//
//  NotificationHandler.swift
//  Dash-Dot-Dash
//
//  Created by Giorgio Ruscigno on 10/7/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import UIKit
import UserNotifications

/// User Notification Delegate
final class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    /// Handles foreground notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}


// MARK: - PushNotifier implementation - adds convenience methods
extension NotificationHandler: PushNotifier {
    
    /// Convenience method to register for push notifications,
    /// assigns self as delegate and defaults to current notification center
    ///
    /// - Parameter application: current application
    internal func registerForPushNotifications(application: UIApplication) {
        registerForPushNotifications(application: application, delegate: self)
    }
    
    /// Convenience method to register provider,
    /// uses the existing providerURL and defaults to URLSession.shared
    ///
    /// - Parameter deviceToken: the encrypted APNs token
    internal func registerProvider(using deviceToken: Data) {
        registerProvider(at: NetworkingConstants.providerURL, using: deviceToken)
    }
}
