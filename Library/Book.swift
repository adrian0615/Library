//
//  Book.swift
//  Library
//
//  Created by Adrian McDaniel on 1/5/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import Foundation


public struct Book : Equatable {
    public static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.checkedOut == rhs.checkedOut && lhs.title == rhs.title && lhs.author == rhs.author && lhs.genre == rhs.genre  && lhs.checkedOutBy == rhs.checkedOutBy
        
    }
    
    
    public var checkedOut: Bool
    public var title: String
    public var author: String
    public var genre: String
    public var checkedOutBy: String?
    
    
    init(checkedOut: Bool, title: String, author: String, genre: String, checkedOutBy: String?) {
        self.checkedOut = checkedOut
        self.title = title
        self.author = author
        self.genre = genre
        self.checkedOutBy = checkedOutBy
        
        
    }
    
    init?(jsonObject: [String: Any]) {
        
        let bookCheckedOutBy = jsonObject["checkedOutBy"] as? String
        
        guard let bookCheckedOut = jsonObject["checkedOut"] as? Bool,
            let booktitle = jsonObject["title"] as? String,
            let bookGenre = jsonObject["genre"] as? String,
            let bookAuthor = jsonObject["author"] as? String else {
                
                return nil
        }
        
        self.init(checkedOut: bookCheckedOut, title: booktitle, author: bookAuthor, genre: bookGenre, checkedOutBy: bookCheckedOutBy)
    }
}

extension Book {
    internal static func array(from jsonObjects: [[String: Any]]) -> [Book]? {
        let bookArray = jsonObjects.flatMap(Book.init(jsonObject:))
        
        if jsonObjects.count != bookArray.count {
            return nil
        }
        
        return bookArray
    }
}

