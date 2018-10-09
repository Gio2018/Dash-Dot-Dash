//
//  NotificationHandlerTests.swift
//  Dash-Dot-Dash Tests
//
//  Created by Giorgio Ruscigno on 10/7/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import UserNotifications
import XCTest
@testable import Dash_Dot_Dash

class NotificationHandlerTests: XCTestCase {
    var notificationHandler: NotificationHandler?
    var registrationExpectation: XCTestExpectation?
    
    override func setUp() {
        notificationHandler = NotificationHandler()
    }
    
    override func tearDown() {
        notificationHandler = nil
    }
}

extension NotificationHandlerTests {
    
    func testThatRegistersForNotifications() {
        //  Given
        guard let handler = notificationHandler else {
            XCTFail("notification handler not initialized")
            return
        }
        //  When
        handler.registerForPushNotifications(application: UIApplication.shared)
        //  Then
        XCTAssertNotNil(UNUserNotificationCenter.current().delegate)
    }
}
