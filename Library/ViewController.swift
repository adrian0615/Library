//
//  ViewController.swift
//  Library
//
//  Created by Adrian McDaniel on 1/5/17.
//  Copyright © 2017 dssafsfsd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let bookStore = BookStore()
    let bookPost = BookPost()
    
    var books: [Book] = []
    var currentBook: Book = Book(checkedOut: false, title: "", author: "", genre: "", checkedOutBy: "")
    
    
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
    
    
    
    
    
    
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var bookCountLabel: UILabel!
    
    @IBAction func prevButton() {
        booksIndex -= 1
        self.currentBook = self.books[self.booksIndex]
        update()
        updateCheckOut()
        updateTextField()
        completedActionLabel.isHidden=true
    }
    @IBAction func nextButton() {
        booksIndex += 1
        self.currentBook = self.books[self.booksIndex]
        update()
        updateCheckOut()
        updateTextField()
        completedActionLabel.isHidden=true
    }
    
    @IBOutlet var checkOutBookLabel: UILabel!
    @IBOutlet var checkOutSwitch: UISwitch!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var enterInstructionsLabel: UILabel!
    @IBOutlet var completedActionLabel: UILabel!
    
    
    @IBAction func switchChanged(_ sender: Any) {
        updateTextField()
        
    }
    
    
    
    func updateCheckOut() {
        if currentBook.checkedOut == true {
            checkOutBookLabel.text = "Return Book"
        } else {
            checkOutBookLabel.text = "Checkout Book"
        }
    }
    
    func updateTextField() {
        if checkOutSwitch.isOn == false {
            checkOutBookLabel.isHighlighted = false
            userNameTextField.isHidden = true
            enterInstructionsLabel.isHidden = true
        } else if checkOutSwitch.isOn == true {
            checkOutBookLabel.isHighlighted = true
            userNameTextField.isHidden = false
            enterInstructionsLabel.isHidden = false
            userNameTextField.isEnabled = checkOutSwitch.isOn
            if currentBook.checkedOut == true {
                enterInstructionsLabel.text = "Enter Correct Name to Return Book"
            } else {
                enterInstructionsLabel.text = "Enter Name to Checkout Book"
            }
        }
        
    }
    
    func updateStatus() {
        if currentBook.checkedOut == true {
            statusLabel.text = "Checked out by: \(currentBook.checkedOutBy)"
        } else {
            statusLabel.text = "Available"
        }
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Don't do anything if there is no text
        guard let userName = textField.text else {
            return false
        }
        
        // Clear out the text
        textField.text = nil
        // Deal with the entry
        
        if currentBook.checkedOut == false {
            bookPost.postCheckout(title: currentBook.title, userName: userName)
            print(userName)
            checkOutSwitch.isOn = false
            completedActionLabel.isHidden = false
            completedActionLabel.text = "Book Checked Out"
        } else {
            bookPost.postReturn(title: currentBook.title, userName: userName)
            print(userName)
            checkOutSwitch.isOn = false
            completedActionLabel.isHidden = false
            completedActionLabel.text = "Book Returned"
        }
        bookStore.fetchGlobalBooks { result in
            switch result {
            case let .success(array):
                self.books = array
                self.currentBook = self.books[self.booksIndex]
                self.update()
                self.updateCheckOut()
                self.updateTextField()
            case let .failure(error):
                print("Failed to retrieve books. Error: \(error)")
            }
        }
        update()
        updateCheckOut()
        updateTextField()
        updateStatus()
        return false
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        bookStore.fetchGlobalBooks { result in
            switch result {
            case let .success(array):
                self.books = array
                self.currentBook = self.books[self.booksIndex]
                self.update()
                self.updateCheckOut()
                self.updateTextField()
            case let .failure(error):
                print("Failed to retrieve books. Error: \(error)")
            }
            print(result)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.update()
        self.updateCheckOut()
        self.updateTextField()
        completedActionLabel.isHidden=true
        
    }
    
    func update() {
        updateStatus()
        titleLabel.text = currentBook.title
        authorLabel.text = currentBook.author
        genreLabel.text = currentBook.genre
        bookCountLabel.text = "\(String(booksIndex + 1)) of \(String(books.count))"
    }
    
    
    
    
    
}
    
