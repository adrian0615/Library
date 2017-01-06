//
//  BookTests.swift
//  Library
//
//  Created by Adrian McDaniel on 1/5/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import XCTest
@testable import Library

class BookTests: XCTestCase {
    
    func testBookResults() {
        let sampleUser: [String: Any?] = ["checkedOut": false, "title": "Book", "author": "Writer", "genre": "Book Genre", "checkedOutBy": "user@user.com"]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleUser, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        let dictionary = Book(jsonObject: jsonObject)!
        let expected = Book(checkedOut: false, title: "Book", author: "Writer", genre: "Book Genre", checkedOutBy: "user@user.com")
        
        XCTAssertEqual(dictionary, expected)
    }
    
    
    func testBookResults2() {
        let sampleUser: [String: Any?] = ["checkedOut": true, "title": "Novel", "author": "Author", "genre": "Genre", "checkedOutBy": "some@one.com"]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleUser, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        let dictionary = Book(jsonObject: jsonObject)!
        let expected = Book(checkedOut: true, title: "Novel", author: "Author", genre: "Genre", checkedOutBy: "some@one.com")
        
        XCTAssertEqual(dictionary, expected)
    }
    
}
