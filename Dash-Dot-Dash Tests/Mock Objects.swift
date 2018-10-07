//
//  Mock Objects.swift
//  Dash-Dot-Dash Tests
//
//  Created by Giorgio Ruscigno on 10/7/18.
//  Copyright © 2018 Giorgio Ruscigno. All rights reserved.
//

import UserNotifications
import XCTest
@testable import Dash_Dot_Dash


/// Mock Puch Notifier
class MockNotifier: PushNotifier {
    //  intentionally left empty
}


/// Mock URLSession
class MockURLSession: URLSession {
    
    var resumeExpectation: XCTestExpectation?
    
    var registrationRequest: URLRequest?
    
    convenience init(expectation: XCTestExpectation?) {
        self.init()
        self.resumeExpectation = expectation
    }
    
    override func dataTask(with request: URLRequest) -> URLSessionDataTask {
        let dataTask = MockUrlDataTask()
        dataTask.resumeExpectation = resumeExpectation
        registrationRequest = request
        return dataTask
    }
}


/// Mock URLSessionDataTask
class MockUrlDataTask: URLSessionDataTask {
    
    var resumeExpectation: XCTestExpectation?
    
    
    override func resume() {
        resumeExpectation?.fulfill()
    }
}
