//
//  NotificationController.swift
//  Dash-Dot-Dash Watch Extension
//
//  Created by Giorgio Ruscigno on 10/6/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet var label: WKInterfaceLabel!
    @IBOutlet var image: WKInterfaceImage!
    

    override func didReceive(_ notification: UNNotification,
                             withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
        WKInterfaceDevice.current().play(.success)
        
        let notificationTitle = notification.request.content.title
        label.setText(notificationTitle)
        completionHandler(.custom)
    }
}
