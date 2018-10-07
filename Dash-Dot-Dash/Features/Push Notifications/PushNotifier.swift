//
//  PushNotifier.swift
//  Dash-Dot-Dash
//
//  Created by Giorgio Ruscigno on 10/7/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import UIKit
import UserNotifications


protocol PushNotifier {
    /// application requests registration to APNs
    ///
    /// - Parameter application: current application
    ///   - delegate: notification center delegate
    ///   - center: dependancy injection for UNUserNotificationCenter
    func registerForPushNotifications(application: UIApplication,
                                      delegate: UNUserNotificationCenterDelegate,
                                      center: UNUserNotificationCenter)
    /// sets the provider at the specified url and sends over the device token
    ///
    /// - Parameters:
    ///   - urlString: string representing the provider url
    ///   - deviceToken: encrypted device token
    ///   - session: dependancy injection for URLSession
    func registerProvider(at urlString: String, using deviceToken: Data, session: URLSession)
}


// MARK: - Default implementation
extension PushNotifier {
    
    func registerForPushNotifications(application: UIApplication,
                                      delegate: UNUserNotificationCenterDelegate,
                                      center: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        center.requestAuthorization(options: [.badge, .sound, .alert]) { [weak center, weak delegate] granted, _ in
            guard granted, let center = center, let delegate = delegate else { return }
            
            center.delegate = delegate
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    func registerProvider(at urlString: String, using deviceToken: Data, session: URLSession = URLSession.shared) {
        guard let url = URL(string: urlString) else {
            #warning("TODO: Implement fallback case when provider is not available")
            fatalError("Invalid URL string")
        }
        
        let token = deviceToken.reduce("") {
            $0 + String(format: "%02x", $1)
        }
        
        var obj: [String: Any] = ["token": token,
                                  "debug": false]
        #if DEBUG
        obj["debug"] = true
        print("Device Token: \(token)")
        #endif
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: obj)
        } catch {
            print("Error: \(error) - unable to decode token")
        }
        
        session.dataTask(with: request).resume()
    }
}
