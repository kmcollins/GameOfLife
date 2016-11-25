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
    
    
    @IBAction func blankTemplateSelected(sender: UIButton) {
        
    }
    
    @IBAction func basicTemplateSelected(sender: UIButton) {
        
    }
    
    @IBAction func ggTemplateSelected(sender: UIButton) {
        
    }
    
    @IBAction func cancelPressed(sender: UIButton) {
        
    }
    
    @IBAction func savePressed(sender: UIButton) {
        
    }
}
