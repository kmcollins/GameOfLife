//
//  DetailViewController.swift
//  test
//
//  Created by Katie Collins on 11/21/16.
//  Copyright © 2016 CollinsInnovation. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailItem: Colony? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    @IBOutlet var colonyView: UIView!
    
    @IBOutlet var coordinateText: UILabel!
    
    @IBOutlet var numEvolves: UISlider!
    @IBOutlet var textNumEvolves: UILabel!
    
    @IBOutlet var speed: UISlider!
    @IBOutlet var textSpeed: UILabel!
    
    @IBOutlet var wrapping: UISwitch!
    
    var timer: NSTimer?
    
    var currentEvolveNumber: Int = 0

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            /*if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }*/
        }
    }
    
    @IBAction func evolveSliderChanged(sender: UISlider) {
        textNumEvolves.text = String(Int(sender.value))
        currentEvolveNumber = 0
    }
    
    @IBAction func speedSliderChanged(sender: UISlider) {
        var value = Int(sender.value)
        textSpeed.text = "\(value)"
        startTimer(NSTimeInterval(value))
    }
    
    func startTimer(interval: NSTimeInterval) {
        timer = NSTimer.scheduledTimerWithTimeInterval(interval,
                                                       target: self,
                                                       selector: "onTick:",
                                                       userInfo: nil,
                                                       repeats: false)
    }
    
    func onTick(timer:NSTimer){
        if currentEvolveNumber < Int(numEvolves!.value) {
            detailItem!.evolve() // NOTE, colony is a class, so this should update no matter what (reference, not value type)
            currentEvolveNumber += 1
        }
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
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        numEvolves.minimumValue = 0
        numEvolves.maximumValue = 1000
        numEvolves.value = 0
        textNumEvolves.text = String(Int(numEvolves.value))
        // Speed = # of evolutions per second
        speed.minimumValue = 0
        speed.maximumValue = 5
        speed.value = 0
        textSpeed.text = String(Int(speed.value))
        wrapping.on = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

