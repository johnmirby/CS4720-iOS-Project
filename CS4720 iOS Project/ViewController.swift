//
//  ViewController.swift
//  CS4720 iOS Project
//
//  Created by John Irby on 10/16/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var nameToDisplay = ""
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set welcome message from user info name
        if (nameToDisplay == ""){
            welcomeLabel.text = "No User Information Submitted"
        }
        else{
            welcomeLabel.text = "Welcome " + nameToDisplay + "!"
        }
        scoreLabel.text = String(0) + " of 116 Bucket List Items Completed"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

