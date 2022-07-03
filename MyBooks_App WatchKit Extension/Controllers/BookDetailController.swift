//
//  InterfaceController.swift
//  MyBooks_App WatchKit Extension
//
//  Created by Felix Titov on 7/2/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import WatchKit
import Foundation


class BookDetailController: WKInterfaceController {
    
    @IBOutlet weak var descriptionLabel: WKInterfaceLabel!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
    @IBOutlet weak var editionLabel: WKInterfaceLabel!
    @IBOutlet weak var pagesLabel: WKInterfaceLabel!
    @IBOutlet weak var selectionButton: WKInterfaceButton!
    @IBOutlet weak var image: WKInterfaceImage!
    
    
    var book: BookItem!

    override func awake(withContext context: Any?) {
        if let book = context as? BookItem {
            self.book = book
            descriptionLabel.setText(book.bookDescription)
            nameLabel.setText(book.name)
            authorLabel.setText(book.author)
            editionLabel.setText(String(book.edition))
            pagesLabel.setText(String(book.pages))
            image.setImageNamed(book.imageName)
            
            let pickedBooks = Set(UserSettings.userBooks.lazy.map { $0.name })
            selectionButton.setHidden(pickedBooks.contains(book.name))
        }
    }

    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        switch segueIdentifier {
        case "ConfirmedBook":
            return book
        default:
            return book.bookDescription
        }
    }
}
