//
//  EditViewController.swift
//  IosGameOfLife
//
//  Created by daniel bauman on 11/11/16.
//
//

import Foundation
import UIKit

class EditViewController: UIViewController {
    var colony: Colony! {
        didSet {
            navigationItem.title = colony.getName()
        }
    }
    
    @IBOutlet var colonyName: UITextField!
    
    @IBOutlet var blankButton: UIButton!
    @IBOutlet var basicButton: UIButton!
    @IBOutlet var ggButton: UIButton!
    
    // This count is used to determine if user deselects
    // Daniel, let me know if you are confused by this ... it's kind of poor code
    var selectedBasicCount = 0
    var selectedBlankCount = 0
    var selectedGGCount = 0
    
    @IBAction func blankTemplateSelected(sender: UIButton) {
        if selectedBlankCount == 0 {
            blankButton.backgroundColor = UIColor.greenColor()
            basicButton.backgroundColor = UIColor.whiteColor()
            ggButton.backgroundColor = UIColor.whiteColor()
            selectedBasicCount = 0
            selectedGGCount = 0
            selectedBlankCount = 1
        } else {
            selectedBlankCount = 0
            blankButton.backgroundColor = UIColor.whiteColor()
        }
    }
    
    @IBAction func basicTemplateSelected(sender: UIButton) {
        if selectedBasicCount == 0 {
            blankButton.backgroundColor = UIColor.whiteColor()
            basicButton.backgroundColor = UIColor.greenColor()
            ggButton.backgroundColor = UIColor.whiteColor()
            selectedBlankCount = 0
            selectedGGCount = 0
            selectedBasicCount = 1
        } else {
            selectedBasicCount = 0
            basicButton.backgroundColor = UIColor.whiteColor()
        }

    }
    
    @IBAction func ggTemplateSelected(sender: UIButton) {
        if selectedGGCount == 0 {
            blankButton.backgroundColor = UIColor.whiteColor()
            basicButton.backgroundColor = UIColor.whiteColor()
            ggButton.backgroundColor = UIColor.greenColor()
            selectedBlankCount = 0
            selectedBasicCount = 0
            selectedGGCount = 1
        } else {
            selectedGGCount = 0
            ggButton.backgroundColor = UIColor.whiteColor()
        }

    }
    
    @IBAction func savePressed(sender: UIButton) {
        if let colName = colonyName.text {
            colony.setName(colName)
        }
        // Do other set-up for the selected template! check based on the color of button's background --- if green, then select
        if blankButton.backgroundColor == UIColor.greenColor() {
            // Remove all cells from colony
            // Clear view screen completely
            colony.resetColony()
        }
        else if basicButton.backgroundColor == UIColor.greenColor() {
            // Remove all cells from colony
            colony.resetColony()
            // Populate colony w/ the basic template
            // .....
        }
        else if ggButton.backgroundColor == UIColor.greenColor() {
            // Remove all cells from colony
            colony.resetColony()
            // Populate colony w/ the glider gun template
            // .....
        }
        // If none have been selected, then do not touch colony's cells
    }
}
