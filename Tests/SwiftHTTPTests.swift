//
//  SwiftHTTPTests.swift
//  SwiftHTTPTests
//
//  Created by Austin Cherry on 9/16/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import XCTest
import SwiftHTTP

class SwiftHTTPTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetRequest() {
        var request = HTTPTask()
        request.GET("http://vluxe.io", parameters: nil, success: {(response: HTTPResponse) -> Void in
            if response.responseObject != nil {
                XCTAssert(true, "Pass")
            }
            },failure: {(error: NSError, _) -> Void in
                XCTAssert(false, "Failure")
        })
    }
    
    func testAuthRequest() {
        
        var request = HTTPTask()
        var attempted = false
        request.auth = {(challenge: NSURLAuthenticationChallenge) in
            if !attempted {
                attempted = true
                return NSURLCredential(user: "user", password: "passwd", persistence: .ForSession)
            }
            return nil
        }
        request.GET("http://httpbin.org/basic-auth/user/passwd", parameters: nil, success: {(response: HTTPResponse) -> Void in
            if response.responseObject != nil {
                XCTAssert(true, "Pass")
            }
            },failure: {(error: NSError, _) -> Void in
                XCTAssert(false, "Failure")
        })
    }
}
