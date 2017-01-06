//
//  UserTests.swift
//  Library
//
//  Created by Adrian McDaniel on 1/5/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import XCTest
@testable import Library

class UserTests: XCTestCase {
    
    func testUserName() {
        let sampleUser: [String: [String: Any]] = ["user": ["userName": "Billy"]]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleUser, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: [String: Any]]
        let userName = User(jsonObject: jsonObject)!
        let expected = User(name: "Billy")
        
        XCTAssertEqual(userName, expected)
    }
    
    
    func testUserName2() {
        let sampleUser: [String: [String: Any]] = ["user": ["userName": "MarySue"]]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleUser, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: [String: Any]]
        let userName = User(jsonObject: jsonObject)!
        let expected = User(name: "MarySue")
        
        XCTAssertEqual(userName, expected)
    }
    
    func testUserName3() {
        let sampleUser: [String: [String: Any]] = ["user": ["userName": "Adrian"]]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleUser, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: [String: Any]]
        let userName = User(jsonObject: jsonObject)!
        let expected = User(name: "Adrian")
        
        XCTAssertEqual(userName, expected)
    }
    
    
    func testUserNameNotEqual() {
        let sampleUser: [String: [String: Any]] = ["user": ["userName": "Adrian"]]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleUser, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: [String: Any]]
        let userName = User(jsonObject: jsonObject)!
        let expected = User(name: "Aiden")
        
        XCTAssertNotEqual(userName, expected)
    }
    
}
