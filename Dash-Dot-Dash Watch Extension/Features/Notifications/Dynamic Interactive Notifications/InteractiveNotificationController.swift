//
//  InteractiveNotificationController.swift
//  Dash-Dot-Dash Watch Extension
//
//  Created by Giorgio Ruscigno on 10/8/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import Foundation
import UserNotifications
import WatchKit


class InteractiveNotificationController: WKUserNotificationInterfaceController {
    
    private let sequencePlayer = SequencePlayer()
    
    @IBOutlet var messageLabel: WKInterfaceLabel!
    
    @IBAction func playMessage() {
        sequencePlayer.execute()
    }
    
    
    override func didReceive(_ notification: UNNotification,
                             withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
        
        sequencePlayer.setConfiguration(userInfo: notification.request.content.userInfo)
        sequencePlayer.execute()
        
        let notificationTitle = notification.request.content.title
        messageLabel.setText(notificationTitle)
        
        completionHandler(.custom)
    }
}
