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

