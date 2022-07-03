//
//  MyBookRowController.swift
//  MyBooks_App WatchKit Extension
//
//  Created by Felix Titov on 7/3/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit
import WatchKit

class MyBookRowController: NSObject {
    
    var book: BookItem! {
        didSet {
            nameLabel.setText(book.name)
        }
    }
    
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
}
