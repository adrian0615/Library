//
//  BookPost.swift
//  Library
//
//  Created by Adrian McDaniel on 1/6/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

internal enum PostResult {
    //lets you know if we were able to post or not
    case success([Book])
    case failure(BookPost.Error)
}

import Foundation

struct BookPost {
    
    enum Error: Swift.Error {
        case http(HTTPURLResponse)
        //whatever the response was from the URL(Could be URL NOT FOUND, etc)
        case system(Swift.Error)
        //A swift error
        case appNet(AppNetAPI.Error)
        //could be an error with the JSONData coming through
    }

    
    
    func postCheckout(title: String, userName: String, completion: @escaping (PostResult) -> ()) {
        
        let session = URLSession.shared
        let url = URL(string: "https://paul-tiy-library.herokuapp.com/book-checkout.json")!
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        let payload = try! JSONSerialization.data(withJSONObject: ["title": title, "userName": userName], options: [])
        request.httpBody = payload
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            
            if let data = optionalData {
                completion(self.processCheckout(data: data, error: optionalError))
                
                
            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion(.failure(error))
                
                
                print("optionalResponse: \(optionalResponse)")
                
            } else {
                completion(.failure(.system(optionalError!)))
            }
        }
        task.resume()
    }
    
    func processCheckout(data: Data, error: Swift.Error?) -> PostResult {
        if let books = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]] {
            if let newBooks = Book.array(from: books) {
                return .success(newBooks)
            } else {
                return .failure(.appNet(.invalidJSONData))
            }
        } else {
            return .failure(.system(error!))
        }
    }
    
    func postReturn(title: String, userName: String, completion: @escaping (PostResult) -> ()) {
        
        let session = URLSession.shared
        let url = URL(string: "https://paul-tiy-library.herokuapp.com/book-return.json")!
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        let payload = try! JSONSerialization.data(withJSONObject: ["title": title, "userName": userName], options: [])
        request.httpBody = payload
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            
            if let data = optionalData {
                completion(self.processReturn(data: data, error: optionalError))
                
                
            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion(.failure(error))
                
                
                print("optionalResponse: \(optionalResponse)")
                
            } else {
                completion(.failure(.system(optionalError!)))
            }
        }
        task.resume()
    }
    
    func processReturn(data: Data, error: Swift.Error?) -> PostResult {
    
        if let books = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]] {
        if let newBooks = Book.array(from: books) {
            return .success(newBooks)
        } else {
            return .failure(.appNet(.invalidJSONData))
            }
        } else {
            return .failure(.system(error!))
        }
    }
}


