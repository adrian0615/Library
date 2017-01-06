//
//  User.swift
//  Library
//
//  Created by Adrian McDaniel on 1/5/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import Foundation


public struct User : Equatable {
    public static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
    }
    
    public var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init?(jsonObject: [String: [String:Any]]) {
        guard let userName = jsonObject["user"]?["userName"] as? String else {
                // Don't have enough information to construct a Post
                return nil
        }
        self.init(name: userName)
    }

    
}
