//
//  BookStore.swift
//  Library
//
//  Created by Adrian McDaniel on 1/6/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import Foundation


internal enum BooksResult {
    //lets you know if we were able to fetch a collection of posts of not
    case success([Book])
    case failure(BookStore.Error)
}

internal final class BookStore {
    enum Error: Swift.Error {
        case http(HTTPURLResponse)
        //whatever the response was from the URL(Could be URL NOT FOUND, etc)
        case system(Swift.Error)
        //A swift error
        case appNet(AppNetAPI.Error)
        //could be an error with the JSONData coming through
    }
    //We are just putting a URLSession type to 'session' based on the default configuration of a URL session
    fileprivate let session: URLSession = {
        return URLSession(configuration: .default)
    }()
    //reaching out for posts while checking for multiple errors if we don't receive them
    internal func fetchGlobalBooks(completion: @escaping (BooksResult) -> ()) {
        //dataTask retrives the contents of the URL
        let task = session.dataTask(with: AppNetAPI.globalStreamURL) { (optionalData, optionalResponse, optionalError) in
            
            // this shows that the data was properly collected
            if let data = optionalData {
                completion(self.processRecentBooksRequest(data: data, error: optionalError))
                
                //this shows that there was an httpResponse error (404 not found, etc)
            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion(.failure(error))
                
                //this shows that there was a system error
            } else {
                completion(.failure(.system(optionalError!)))
            }
        }
        //resume must be called because you started the dataTask
        task.resume()
    }
    //If we did receive the data we will process the JSON data and convert it
    internal func processRecentBooksRequest(data: Data, error: Swift.Error?) -> BooksResult {
        
        if let books = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]] {
            if let newBooks = Book.array(from: books) {
                return .success(newBooks)
            } else {
                //this  error is if the JSON data is invalid
                return .failure(.appNet(.invalidJSONData))
            }
        } else {
            //this is if there is a system error
            return .failure(.system(error!))
        }
    }
}
