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
    var book: BookItem!

    override func awake(withContext context: Any?) {
        if let book = context as? BookItem {
            self.book = book
            descriptionLabel.setText(book.bookDescription)
        }
    }

    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        book.bookDescription
    }

}
