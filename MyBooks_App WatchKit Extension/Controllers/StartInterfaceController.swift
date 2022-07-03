//
//  StartInterfaceController.swift
//  MyBooks_App WatchKit Extension
//
//  Created by Felix Titov on 7/3/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit
import WatchKit

class StartInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!

    
    override func willActivate() {
        super.willActivate()
        setupTable()
    }
    
    func setupTable() {
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
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if let rowController = table.rowController(at: rowIndex) as? MyBookRowController {
            return rowController.book
        }
        return nil
    }
}
