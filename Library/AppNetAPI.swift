//
//  AppNetAPI.swift
//  Library
//
//  Created by Adrian McDaniel on 1/6/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import Foundation


internal struct AppNetAPI {
    internal enum Error: Swift.Error {
        case invalidJSONData
    }
    
    internal static let globalStreamURL: URL = URL(string: "https://paul-tiy-library.herokuapp.com/book-list.json")!
    
    }

