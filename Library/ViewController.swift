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
        completedActionLabel.isHidden=true
    }
    @IBAction func nextButton() {
        booksIndex += 1
        self.currentBook = self.books[self.booksIndex]
        update()
        completedActionLabel.isHidden=true
    }
    
    @IBOutlet var checkOutBookLabel: UILabel!
    @IBOutlet var checkOutSwitch: UISwitch!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var enterInstructionsLabel: UILabel!
    @IBOutlet var completedActionLabel: UILabel!
    
    
    @IBAction func switchChanged(_ sender: Any) {
        update()
        
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
            bookPost.postCheckout(title: currentBook.title, userName: userName) { checkoutResult in
                switch checkoutResult {
        
                case let .success(array) :
                    self.books = array
                    self.currentBook = self.books[self.booksIndex]
                    self.update()
                    
                    print("----------------------")
                    print("success")
                    print("----------------------")
        
                    self.checkOutSwitch.isOn = false
                    self.completedActionLabel.isHidden = false
                    self.completedActionLabel.text = "Book Checked Out"
                    self.currentBook = self.books[self.booksIndex]
                
                    
                case let .failure(error) :
                    print("Failed to Checkout Book.  Error: \(error)")
                    
                }
            }
            return true
        } else {
            
            bookPost.postReturn(title: currentBook.title, userName: userName) { returnResult in
                switch returnResult {
                case let .success(array) :
                    self.books = array
                    self.currentBook = self.books[self.booksIndex]
                    self.update()
            print("----------------------")
            print("success")
            print("----------------------")
            self.checkOutSwitch.isOn = false
            self.completedActionLabel.isHidden = false
            self.completedActionLabel.text = "Book Returned"
                    
                    
                    
                case let .failure(error):
                    print("Failed to Return Book. Error: \(error)")
        }
            }
            return true
        }

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
            case let .failure(error):
                print("Failed to retrieve books. Error: \(error)")
            }
            print(result)
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.update()
        

        completedActionLabel.isHidden=true
        
    }
    
    func update() {
        OperationQueue.main.addOperation {
            
        self.updateStatus()
        self.updateTextField()
        self.updateCheckOut()
        self.titleLabel.text = self.currentBook.title
        self.authorLabel.text = self.currentBook.author
        self.genreLabel.text = self.currentBook.genre
        self.bookCountLabel.text = "\(String(self.booksIndex + 1)) of \(String(self.books.count))"
    }
    }
    
    
    //  }
}

