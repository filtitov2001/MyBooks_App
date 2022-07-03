//
//  StartInterfaceController.swift
//  MyBooks_App WatchKit Extension
//
//  Created by Felix Titov on 7/3/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit
import WatchKit
import WatchConnectivity

class StartInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!

    
    override func willActivate() {
        super.willActivate()
        setupTable()
        sendSelectedBooksToPhone()
    }
    
    func setupTable() {
        print(UserSettings.userBooks)
        let pickedBooks = UserSettings.userBooks
        table.setNumberOfRows(pickedBooks.count, withRowType: "myBookRow")
        
        for (index, book) in pickedBooks.enumerated() {
            if let rowController = table.rowController(at: index) as? MyBookRowController {
                rowController.nameLabel.setText(book.name)
                let book = pickedBooks[index]
                rowController.book = book
            }
        }
    }
    
    func sendSelectedBooksToPhone() {
        if WCSession.isSupported() {
            let session = WCSession.default
            let pickedBooks = UserSettings.userBooks.map { books in
                books.representation
            }
            
            do {
                let dict: [String: Any] = ["books": pickedBooks]
                try session.updateApplicationContext(dict)
            } catch let error {
                print(error)
            }
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if let rowController = table.rowController(at: rowIndex) as? MyBookRowController {
            return rowController.book
        }
        return nil
    }
    
    @IBAction func deleteAll() {
        UserSettings.userBooks = []
        setupTable()
        sendSelectedBooksToPhone()
    }
}
