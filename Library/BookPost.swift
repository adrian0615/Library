//
//  BookPost.swift
//  Library
//
//  Created by Adrian McDaniel on 1/6/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import Foundation

struct BookPost {

    func postCheckout(title: String, userName: String) {
    
    let session = URLSession.shared
    //let url = URL(string: "https://paul-tiy-library.herokuapp.com/book-return.json")!
    let url = URL(string: "https://paul-tiy-library.herokuapp.com/book-checkout.json")!
    var request = URLRequest(url: url)
    
    
    request.httpMethod = "POST"
    request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    
    
    let payload = try! JSONSerialization.data(withJSONObject: ["title": title, "userName": userName], options: [])
    request.httpBody = payload
    
    let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
        guard let data = optionalData,
            let objects = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]]
            else {
                print("optionalResponse: \(optionalResponse)")
                print("optionalError: \(optionalError)")
                
                return
        }
        
        print(objects)
        print("optionalResponse: \(optionalResponse)")
        print("optionalError: \(optionalError)")
        
    }
    task.resume()
}
    func postReturn(title: String, userName: String) {
        
        let session = URLSession.shared
        let url = URL(string: "https://paul-tiy-library.herokuapp.com/book-return.json")!
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        let payload = try! JSONSerialization.data(withJSONObject: ["title": title, "userName": userName], options: [])
        request.httpBody = payload
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            guard let data = optionalData,
                let objects = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]]
                else {
                    print("optionalResponse: \(optionalResponse)")
                    print("optionalError: \(optionalError)")
                    
                    return
            }
            
            print(objects)
            print("optionalResponse: \(optionalResponse)")
            print("optionalError: \(optionalError)")
            
        }
        task.resume()
    }
    
    
    
}
