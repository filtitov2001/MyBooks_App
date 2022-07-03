//
//  DescriptionInterfaceController.swift
//  MyBooks_App WatchKit Extension
//
//  Created by Felix Titov on 7/3/22.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit
import WatchKit

class DescriptionInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var descriptionLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let description = context as? String {
            descriptionLabel.setText(description)
        }
    }
    
    @IBAction func cancelSelected() {
        dismiss()
    }
}
