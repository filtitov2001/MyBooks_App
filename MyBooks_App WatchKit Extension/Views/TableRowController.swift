//
//  TableRowController.swift
//  MyBooks_App WatchKit Extension
//
//  Created by Felix Titov on 7/3/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import WatchKit

class TableRowController: NSObject {
    
    var book: BookItem! {
        didSet {
            nameLabel.setText(book.name)
            authorLabel.setText(book.author)
        }
    }
    
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var authorLabel: WKInterfaceLabel!
}
