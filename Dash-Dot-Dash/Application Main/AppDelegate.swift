//
//  AppDelegate.swift
//  Dash-Dot-Dash
//
//  Created by Giorgio Ruscigno on 10/6/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?
    
    private let notificationHandler = NotificationHandler()
}


// MARK: - Application Delegate
extension AppDelegate: UIApplicationDelegate{

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificationHandler.registerForPushNotifications(application: application)
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        notificationHandler.registerProvider(using: deviceToken)
    }
}
