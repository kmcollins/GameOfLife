//
//  DetailViewController.swift
//  test
//
//  Created by Katie Collins on 11/21/16.
//  Copyright © 2016 CollinsInnovation. All rights reserved.
//

import UIKit
//import Framework

class DetailViewController: UIViewController, UIPickerViewDelegate {

    var detailItem: Colony? {
        didSet {
            // Update the view.
            self.configureView()
            navigationItem.title = detailItem?.getName()
            self.displayColony()
        }
    }
    
    @IBOutlet weak var colonyView: ColonyDrawer!
    @IBOutlet weak var coordinateText: UILabel!
    @IBOutlet weak var speed: UISlider!
    @IBOutlet weak var textSpeed: UILabel!
    @IBOutlet weak var wrapping: UISwitch!
    @IBOutlet weak var detailLabel: UINavigationItem!
    
    @IBOutlet var templatePicker: UIPickerView! //= UIPickerView()
    @IBOutlet var templateButton: UIButton!
    
    /*var templates: [String, Set<Coordinate] = ["": detailItem!.cells,
    "Blank": Set(),
    "Basic": Set([Coordinate(x:30, y:30), Coordinate(x: 29, y: 29), Coordinate(x: 30, y: 29), Coordinate(x: 30, y: 29)]),
    "Glider Gun": Set()
    ]*/
    
    @IBAction func selectTemplate(sender: AnyObject) {
        //let visibilty = templatePicker.hidden
        templatePicker.hidden = false
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    
    // returns the # of rows in each component..
  /*  func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
        return templates.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        return templates[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        //textfieldBizCat.text = bizCat[row]
        templatePicker.hidden = true;
    }
    */
    @IBOutlet var colonyNameTextField: UITextField!
    
    var timer: NSTimer?
    
    //var currentEvolveNumber: Int = 0
    
    var evolving = false
    
    @IBAction func textChanged(sender: UITextField) {
        detailItem?.setName(sender.text!)
    }
    
    func configureView() {
        templatePicker.hidden = true
        // Update the user interface for the detail item.
        if self.detailItem != nil {
            /*if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }*/
        }
    }
    
    @IBAction func play(sender: AnyObject) {
        evolving = true
        print(speed.value)
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
        detailItem!.evolve()
        self.displayColony()
    }
    
    
    @IBAction func changedWrapping(sender: UISwitch) {
        if sender.on {
            detailItem!.useWrapping()
        } else {
            detailItem!.dontUseWrapping()
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

