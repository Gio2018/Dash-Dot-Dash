//
//  AppDelegate.swift
//  Dash-Dot-Dash
//
//  Created by Giorgio Ruscigno on 10/6/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerForPushNotifications(application: application, delegate: self)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        registerProvider(at: NetworkingConstants.providerURL, using: deviceToken)
    }
}


// MARK: - Push Notifications Handler
extension AppDelegate: PushNotifier, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}
