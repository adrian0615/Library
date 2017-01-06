//
//  ViewController.swift
//  Library
//
//  Created by Adrian McDaniel on 1/5/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let bookStore = BookStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookStore.fetchGlobalPosts { result in
            print(result)
            //print(String())
        }
    }


}

