//
//  DetailViewController.swift
//  test
//
//  Created by Katie Collins on 11/21/16.
//  Copyright © 2016 CollinsInnovation. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var detailItem: Colony? {
        didSet {
            // Update the view.
            self.configureView()
            navigationItem.title = detailItem?.getName()
            let originalCells = detailItem?.getCells()
            if originalCells != Set() {
                templateCells[0] = originalCells!
            }
            self.displayColony()
        }
    }
    
    @IBOutlet weak var colonyView: ColonyDrawer!
    @IBOutlet weak var coordinateText: UILabel!
    @IBOutlet weak var speed: UISlider!
    @IBOutlet weak var textSpeed: UILabel!
    @IBOutlet weak var wrapping: UISwitch!
    @IBOutlet weak var detailLabel: UINavigationItem!
    
    @IBOutlet var templatePicker: UIPickerView!
    @IBOutlet var templateButton: UIButton!
    
    var templates = ["Current", "Blank", "Basic", "Glider Gun"]
    var templateCells = [Set(), Set(), Set([Coordinate(x:30, y:30), Coordinate(x: 29, y: 29), Coordinate(x: 30, y: 29), Coordinate(x: 31, y: 29)]), Set()]
    
    @IBAction func selectTemplate(sender: AnyObject) {
        let makeVisible = templatePicker.hidden
        if makeVisible {
            templatePicker.hidden = false
            templateButton.setTitle("Done", forState: .Normal)
        } else {
            templatePicker.hidden = true
            templateButton.setTitle("Select Template", forState: .Normal)
        }
    }
    
    // Returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    
    // Returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
        return templates.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return templates[row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        let newCells = templateCells[row]
        detailItem!.replaceCellsWith(newCells)
        print("in change: \(templateCells[0])")
        self.displayColony()
    }
    
    @IBOutlet var colonyNameTextField: UITextField!
    
    var timer: NSTimer?
    
    //var currentEvolveNumber: Int = 0
    
    var evolving = false
    
    @IBAction func textChanged(sender: UITextField) {
        detailItem?.setName(sender.text!)
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
    
    func startTimer(interval: NSTimeInterval) {
        timer = NSTimer.scheduledTimerWithTimeInterval(interval,
                                                       target: self,
                                                       selector: #selector(DetailViewController.onTick(_:)),
                                                       userInfo: nil,
                                                       repeats: true)
    }
    
    func onTick(timer:NSTimer){
        if detailItem != nil {
            detailItem!.evolve()
            self.displayColony()
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

