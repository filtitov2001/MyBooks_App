//
//  ConfirmedInterfaceController.swift
//  MyBooks_App WatchKit Extension
//
//  Created by Felix Titov on 7/3/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import WatchKit
import Foundation


class ConfirmedInterfaceController: WKInterfaceController {
    var book: BookItem!
    @IBOutlet weak var confirmationLabel: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let book = context as? BookItem {
            self.book = book
            setTitle(book.name)
            confirmationLabel.setText("Вы уверены что хотите данную книгу?")
            
        }
    }

    @IBAction func bookSelected() {
        UserSettings.userBooks.append(book)
        popToRootController()
    }
    
    @IBAction func cancelSelected() {
        pop()
    }
}
