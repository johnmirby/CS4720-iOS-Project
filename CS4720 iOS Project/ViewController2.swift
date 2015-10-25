//
//  ViewController2.swift
//  CS4720 iOS Project
//
//  Created by John Irby on 10/25/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "infoSegue"){
            if let svc = segue.destinationViewController as? ViewController {
                svc.nameToDisplay = firstNameText.text! + " " + lastNameText.text!
            }
        }
        if (segue.identifier == "skipInfoSegue"){
            if (firstNameText.hasText() && lastNameText.hasText()){
                if let svc = segue.destinationViewController as? ViewController {
                    svc.nameToDisplay = firstNameText.text! + " " + lastNameText.text!
                }
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
}
