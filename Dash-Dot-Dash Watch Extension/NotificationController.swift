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
    
    override init() {
        super.init()
        
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didAppear() {
        super.didAppear()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            WKInterfaceDevice.current().play(.directionUp)
//        }
        Timer.scheduledTimer(withTimeInterval: 0.240, repeats: false) {_ in
            WKInterfaceDevice.current().play(.notification)
        }
    }
    

    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
        WKInterfaceDevice.current().play(.success)
        //Timer.scheduledTimer(withTimeInterval: 0.120, repeats: false) { _ in
            
        //}
        
        let notificationTitle = notification.request.content.title
        label.setText(notificationTitle)
        
        completionHandler(.custom)
    }
}
