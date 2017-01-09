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
        let sampleBook: [String: Any?] = ["checkedOut": false, "title": "Book", "author": "Writer", "genre": "Book Genre", "checkedOutBy": "user@user.com"]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleBook, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        let dictionary = Book(jsonObject: jsonObject)!
        let expected = Book(checkedOut: false, title: "Book", author: "Writer", genre: "Book Genre", checkedOutBy: "user@user.com")
        
        XCTAssertEqual(dictionary, expected)
    }
    
    
    func testBookResults2() {
        let sampleBook: [String: Any?] = ["checkedOut": true, "title": "Novel", "author": "Author", "genre": "Genre", "checkedOutBy": "some@one.com"]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleBook, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        let dictionary = Book(jsonObject: jsonObject)!
        let expected = Book(checkedOut: true, title: "Novel", author: "Author", genre: "Genre", checkedOutBy: "some@one.com")
        
        XCTAssertEqual(dictionary, expected)
    }
    
    func testBookResults3() {
        let sampleBook: [String: Any?] = ["checkedOut": true, "title": "Book", "author": "Author", "genre": "Genre", "checkedOutBy": "some@one.com"]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleBook, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        let dictionary = Book(jsonObject: jsonObject)!
        let expected = Book(checkedOut: true, title: "Novel", author: "Author", genre: "Genre", checkedOutBy: "some@one.com")
        
        XCTAssertNotEqual(dictionary, expected)
    }
    
    func testBookArrayResults() {
        let sampleBooks: [[String: Any?]] = [["checkedOut": true, "title": "Novel", "author": "Author", "genre": "Genre", "checkedOutBy": "some@one.com"], ["checkedOut": false, "title": "Book", "author": "Writer", "genre": "Book Genre", "checkedOutBy": "user@user.com"]]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleBooks, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [[String: Any]]
        let arrayBooks = Book.array(from: jsonObject)!
        let expected = [Book(checkedOut: true, title: "Novel", author: "Author", genre: "Genre", checkedOutBy: "some@one.com"), Book(checkedOut: false, title: "Book", author: "Writer", genre: "Book Genre", checkedOutBy: "user@user.com")]
        
        XCTAssertEqual(arrayBooks, expected)
        
    }
    
    
    func testBookArrayResults2() {
        let sampleBooks: [[String: Any?]] = [["checkedOut": false, "title": "Title", "author": "Scribe", "genre": "None", "checkedOutBy": "billy@bob.com"], ["checkedOut": false, "title": "Book", "author": "Writer", "genre": "Book Genre", "checkedOutBy": "user1@user2.com"]]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleBooks, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [[String: Any]]
        let arrayBooks = Book.array(from: jsonObject)!
        let expected = [Book(checkedOut: false, title: "Title", author: "Scribe", genre: "None", checkedOutBy: "billy@bob.com"), Book(checkedOut: false, title: "Book", author: "Writer", genre: "Book Genre", checkedOutBy: "user1@user2.com")]
        
        XCTAssertEqual(arrayBooks, expected)
        
    }
    
    
    func testBookArrayResults3() {
        let sampleBooks: [[String: Any?]] = [["checkedOut": true, "title": "Title", "author": "Scribe", "genre": "None", "checkedOutBy": "billy@bob.com"], ["checkedOut": false, "title": "Book", "author": "Writer", "genre": "Book Genre", "checkedOutBy": "user1@user2.com"]]
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sampleBooks, options: [])
        let returnedSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [[String: Any]]
        let arrayBooks = Book.array(from: jsonObject)!
        let expected = [Book(checkedOut: false, title: "Title", author: "Scribe", genre: "None", checkedOutBy: "billy@bob.com"), Book(checkedOut: false, title: "Book", author: "Writer", genre: "Book Genre", checkedOutBy: "user1@user2.com")]
        
        XCTAssertNotEqual(arrayBooks, expected)
        
    }
    
}
