//
//  ViewController.swift
//  Library
//
//  Created by Adrian McDaniel on 1/5/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentBook = Book(checkedOut: false, title: "The Martian", author: "Andy Weir", genre: "Science Fiction", checkedOutBy: "none")
    let bookStore = BookStore()
    //let bookPost = BookPost()
    
    /*var booksResult = BooksResult()
     
     
     var books: [Book] {
     switch booksResult.self {
     case let .success(value):
     return value
     case .failure:
     return []
     }
     }
     
     var booksIndex: Int = 0 {
     didSet {
     if booksIndex >= books.count {
     booksIndex %= books.count
     }
     while booksIndex < 0 {
     booksIndex += books.count
     }
     }
     }
     
     var currentBook: Book {
     return books[booksIndex]
     }*/
    
    
    
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var bookCountLabel: UILabel!
    
    /*@IBAction func prevButton() {
     booksIndex -= 1
     }
     @IBAction func nextButton() {
     booksIndex += 1
     }
     @IBAction func checkOutSwitch() {
     if currentBook.checkedOut == false && currentBook.checkedOutBy == "none" {
     checkOutSwitch()
     }
     
     
     }
     @IBOutlet var userNameTextField: UITextField!
     
     @IBAction func enter() {
     userNameTextField.resignFirstResponder()
     }
     @IBAction func userInputTextField()  {
     if currentBook.checkedOut == false && currentBook.checkedOutBy == "none" {
     
     
     }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookStore.fetchGlobalPosts { result in
            print(result)
        }
        //bookPost.postBook()
    }
    
    func update() {
        titleLabel.text = currentBook.title
        authorLabel.text = currentBook.author
        genreLabel.text = currentBook.genre
        //bookCountLabel.text = "\(String(booksIndex)) of \(String(books.count))"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    
    
    
    
    
    
}
    
