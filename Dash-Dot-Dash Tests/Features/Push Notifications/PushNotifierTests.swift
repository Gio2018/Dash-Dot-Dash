//
//  PushNotifierTests.swift
//  Dash-Dot-Dash Tests
//
//  Created by Giorgio Ruscigno on 10/7/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import UserNotifications
import XCTest
@testable import Dash_Dot_Dash

class PushNotifierTests: XCTestCase, UNUserNotificationCenterDelegate {
    
    var notifier: PushNotifier?
    
    override func setUp() {
        notifier = MockNotifier()
    }
    
    override func tearDown() {
        notifier = nil
    }
}


// MARK: - Notification Service Registration
extension PushNotifierTests {
    
    func testThatRegistersForNotifications() {
        //  Given
        guard let notifier = self.notifier else {
            XCTFail("notifier not initialized")
            return
        }
        //  When
        notifier.registerForPushNotifications(application: UIApplication.shared, delegate: self)
        //  Then
        XCTAssertTrue(UNUserNotificationCenter.current().delegate === self)
    }
}


// MARK: - Provider registration
extension PushNotifierTests {
    
    func testThatRegistersProvider() {
        //  Given
        let resumeExpectation = expectation(description: "Task was resumed")
        let session = MockURLSession(expectation: resumeExpectation)
        guard let notifier = self.notifier else {
            XCTFail("notifier not initialized")
            return
        }
        //  When
        notifier.registerProvider(at: NetworkingConstants.providerURL, using: Data(), session: session)
        //  Then
        XCTAssertEqual(session.registrationRequest?.httpMethod, "POST")
        waitForExpectations(timeout: 5, handler: { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        })
    }
}
