//
//  DetailViewController.swift
//  test
//
//  Created by Katie Collins on 11/21/16.
//  Copyright © 2016 CollinsInnovation. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var templateData: TemplateData?
    
    var detailItem: Colony? {
        didSet {
            // Update the view.
            self.configureView()
            navigationItem.title = detailItem?.getName()
            let originalCells = detailItem?.getCells()
            if originalCells != Set() {
                //templateCells[0] = originalCells!
                templateData!.setCurrentCells(originalCells!)
            }
            colonyNameTextField.text = detailItem?.getName()
            //colonyNameTextField.textColor = UIColor.lightGrayColor()
            self.displayColony()
        }
    }
    
    @IBOutlet var colonyNameTextField: UITextField!
    @IBOutlet weak var colonyView: ColonyDrawer!
    @IBOutlet weak var coordinateText: UILabel!
    @IBOutlet weak var speed: UISlider!
    @IBOutlet weak var textSpeed: UILabel!
    @IBOutlet weak var wrapping: UISwitch!
    @IBOutlet weak var detailLabel: UINavigationItem!
    @IBOutlet var addColStack: UIStackView!
    @IBOutlet var addColonyTextField: UITextField!
    @IBOutlet var templatePicker: UIPickerView!
    @IBOutlet var templateButton: UIButton!
    @IBOutlet weak var colonyWidthTextField: UITextField!
    @IBOutlet weak var colonyHeightTextField: UITextField!
    @IBOutlet weak var editNameButton: UIButton!
    @IBOutlet weak var addColonyButton: UIButton!
    @IBOutlet weak var editNameStack: UIStackView!
    
    var secondColony: Colony?
    
    var masterController: MasterViewController?
    
    /*var templates = ["Current", "Blank", "Basic", "Glider Gun"]
    var templateCells = [Set(), Set(), Set([Coordinate(x:30, y:30), Coordinate(x: 29, y: 29), Coordinate(x: 30, y: 29), Coordinate(x: 31, y: 29)]), Set()]*/
    
    @IBAction func selectTemplate(sender: AnyObject) {
        let makeVisible = templatePicker.hidden
        if makeVisible {
            templatePicker.setContentHuggingPriority(250, forAxis: UILayoutConstraintAxis.Vertical)
            templatePicker.setContentCompressionResistancePriority(750, forAxis: UILayoutConstraintAxis.Vertical)
            templatePicker.hidden = false
            templateButton.setTitle("Done", forState: .Normal)
        } else {
            templatePicker.hidden = true
            templatePicker.setContentHuggingPriority(750, forAxis: UILayoutConstraintAxis.Vertical)
            templatePicker.setContentCompressionResistancePriority(250, forAxis: UILayoutConstraintAxis.Vertical)
            templateButton.setTitle("Select Template", forState: .Normal)
        }
    }
    
    // Returns the number of 'columns' to display...UIPickerView!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // Returns the # of rows in each component.. ..UIPickerView!
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        //return templates.count
        return templateData!.getCount()
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return templateData!.nameForRow(row)
        //return templates[row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        //let newCells = templateCells[row]
        let newCells = templateData!.cellsForRow(row)
        detailItem!.replaceCellsWith(newCells)
        self.displayColony()
    }
    
    @IBAction func addTemplate(sender: AnyObject) {
        /*templates.append(detailItem!.getName())
        templateCells.append(detailItem!.getCells())*/
        templateData!.addTemplate(detailItem!.getName(), cells: detailItem!.getCells())
        templatePicker.reloadAllComponents()
    }
    
    var timer: NSTimer?
    
    //var currentEvolveNumber: Int = 0
    
    var evolving = false
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == colonyNameTextField {
            saveText(textField.text!)
            colonyNameTextField.resignFirstResponder()
        }
        else if textField == addColonyTextField {
            addToScreen(textField.text)
            addColonyTextField.resignFirstResponder()
        }
        return true
    }
    
    func saveText(text: String) {
        detailItem?.setName(text)
        navigationItem.title = detailItem?.getName()
        masterController?.tableView.reloadData()
    }
    
    func addToScreen(colName: String?) {
        if let name = colName {
            if let index = masterController?.colonyHolder.indexOfName(name) {
                let col2 = masterController?.colonyHolder.colonies[index]
                secondColony = col2
                colonyView.secondColony = self.secondColony                
                self.displayColony()
            }
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if self.detailItem != nil {
            /*if let label = self.detailDescriptionLabel {
             label.text = detail.description
             }*/
        }
    }
    
    @IBAction func play(sender: AnyObject) {
        evolving = true
        startTimer(NSTimeInterval(5/speed.value))
    }
    
    func stopTimer() {
        if let t = timer {
            t.invalidate()
        }
    }
    
    @IBAction func speedSliderChanged(sender: UISlider) {
        let value = Int(sender.value)
        textSpeed.text = "\(value)"
        if value == 0 {
            stopTimer()
            evolving = false
        } else {
            if evolving {
                stopTimer()
                startTimer(NSTimeInterval(5/sender.value))
            }
        }
    }
    
    @IBAction func editNameButtonPressed(sender: AnyObject) {
        let hidden = self.editNameStack.hidden
        if hidden {
            editNameButton.setTitle("done editing", forState: .Normal)
            self.editNameStack.hidden = false
        } else {
            editNameButton.setTitle("Edit Name/Templates", forState: .Normal)
            self.editNameStack.hidden = true
        }
    }
    
    
    @IBAction func addColonyResizeButtonPressed(sender: AnyObject) {
        let hidden = self.addColStack.hidden
        if hidden {
            addColonyButton.setTitle("done adding/resizing", forState: .Normal)
            self.addColStack.hidden = false
        } else {
            addColonyButton.setTitle("Add Colony/Resize", forState: .Normal)
            self.addColStack.hidden = true
        }
    }
    
    
    func startTimer(interval: NSTimeInterval) {
        timer = NSTimer.scheduledTimerWithTimeInterval(interval,
                                                       target: self,
                                                       selector: #selector(DetailViewController.onTick(_:)),
                                                       userInfo: nil,
                                                       repeats: true)
    }
    
    func onTick(timer:NSTimer){
        if let col1 = detailItem {
            if let col2 = secondColony {
                col1.evolve()
                col2.evolve()
                self.displayColony()
            } else {
                col1.evolve()
                self.displayColony()
            }
        }
    }
    
    
    @IBAction func changedWrapping(sender: UISwitch) {
        if detailItem != nil {
            detailItem!.setWrapping(sender.on)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        // Speed = # of evolutions per second
        speed.minimumValue = 0
        speed.maximumValue = 50
        speed.value = 0
        textSpeed.text = String(Int(speed.value))
        wrapping.on = false
        templatePicker.hidden = true
        
        self.templatePicker.delegate = self
        self.templatePicker.dataSource = self
        
        self.colonyNameTextField.delegate = self
        self.addColonyTextField.delegate = self
    }
    
    
    @IBAction func resizeButtonPressed(sender: AnyObject) {
        var colonyHeight = 60
        var colonyWidth = 60
        if let newHeightString = self.colonyHeightTextField.text {
            if let newHeight = Int(newHeightString) {
                colonyHeight = newHeight
            }
        }
        if let newWidthString = self.colonyWidthTextField.text {
            if let newWidth = Int(newWidthString) {
                colonyWidth = newWidth
            }
        }
        self.detailItem!.resetColony()
        self.detailItem!.xMax = colonyWidth
        self.detailItem!.yMax = colonyHeight
        self.displayColony()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayColony() {
        if let colony = detailItem {
            self.colonyView.currentColony = colony
            self.colonyView.setNeedsDisplay()
        }
    }
    
}

