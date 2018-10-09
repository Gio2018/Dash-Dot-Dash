//
//  InteractiveNotificationController.swift
//  Dash-Dot-Dash Watch Extension
//
//  Created by Giorgio Ruscigno on 10/8/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class InteractiveNotificationController: WKUserNotificationInterfaceController {
    
    @IBOutlet var messageLabel: WKInterfaceLabel!
    
    @IBAction func playMessage() {
        playHapticSequence(sequence: hapticSequence)
    }
   
    
    override func didReceive(_ notification: UNNotification,
                             withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Void) {
        playHapticSequence(sequence: shortHapticSequence)
        
        let notificationTitle = notification.request.content.title
        messageLabel.setText(notificationTitle)
        
        completionHandler(.custom)
    }
}


// MARK: - Haptic Engine Handling
extension InteractiveNotificationController {
    
    /// Executes the haptic sequence representing the user message
    private func playHapticSequence(sequence: [WKHapticType]) {
        
        var delay: TimeInterval = 0.0
        
        sequence.forEach { type in
            Timer.scheduledTimer(withTimeInterval: delay, repeats: false) {_ in
                WKInterfaceDevice.current().play(type)
            }
            delay += 0.6
        }
    }
}

#warning("TODO: Remove bedore production")
// MARK: - Test data
extension InteractiveNotificationController {
    
    private var hapticSequence: [WKHapticType] {
        return [.start,
                .directionUp,
                .directionDown,
                .stop,
                .directionUp,
                .directionDown,
                .directionUp,
                .retry]
    }
    
    private var shortHapticSequence: [WKHapticType] {
        return [.start,
                .directionUp,
                .directionDown,
                .stop]
    }
}
