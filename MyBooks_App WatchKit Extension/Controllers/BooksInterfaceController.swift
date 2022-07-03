//
//  BooksInterfaceController.swift
//  MyBooks_App WatchKit Extension
//
//  Created by Felix Titov on 7/3/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import WatchKit
import Foundation


class BooksInterfaceController: WKInterfaceController {
    
    private var map = [GenreType: [BookItem]]()
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        for book in BookItem.getBooks() {
            var booksByGenre = map[book.genre] ?? [BookItem]()
            booksByGenre.append(book)
            map[book.genre] = booksByGenre
        }
        
        for (genre, books) in map {
            addSection(genre: genre, books: books)
        }
    }
    
    func addSection(genre: GenreType, books: [BookItem]) {
        let rows = table.numberOfRows
        table.insertRows(at: NSIndexSet(index: rows) as IndexSet, withRowType: "headerRow")
        
        let itemRows = NSIndexSet(indexesIn: NSRange(location: rows + 1, length: books.count))
        table.insertRows(at: itemRows as IndexSet, withRowType: "bookRow")
        
        for index in rows..<table.numberOfRows {
            let controller = table.rowController(at: index)
            
            if let controller = controller as? HeaderRowController {
                controller.image.setImageNamed(genre.rawValue.lowercased())
                controller.sectionLabel.setText(genre.descriptionForWatch())
            } else if let controller = controller as? TableRowController {
                let book = books[index - rows - 1]
                controller.book = book
            }
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        var pickedIndex = -1
        var pickedBook: BookItem?
        for (_, books) in map {
            pickedIndex += 1
            for book in books {
                pickedIndex += 1
                if rowIndex == pickedIndex {
                    pickedBook = book
                }
            }
        }
        
        return pickedBook
    }
}
