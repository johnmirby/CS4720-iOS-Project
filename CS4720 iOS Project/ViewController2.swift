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
    
    var firstName = ""
    var lastName = ""
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let path = NSTemporaryDirectory() + "userInfo.txt"
            let readString = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            var valuesArray = readString.componentsSeparatedByString(",")
            firstName = valuesArray[0]
            lastName = valuesArray[1]
            email = valuesArray[2]
            firstNameText.text! = firstName
            lastNameText.text! = lastName
            emailText.text! = valuesArray[2]
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "infoSegue"){
            if let svc = segue.destinationViewController as? ViewController {
                svc.nameToDisplay = firstNameText.text! + " " + lastNameText.text!
            }
            let userInfoText = firstNameText.text! + "," + lastNameText.text! + "," + emailText.text!
            let path = NSTemporaryDirectory() + "userInfo.txt"
            do {
                try userInfoText.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            } catch let error as NSError {
                print(error)
            }
        }
        if (segue.identifier == "skipInfoSegue"){
            if (firstNameText.hasText() && lastNameText.hasText()){
                if let svc = segue.destinationViewController as? ViewController {
                    if (firstName == "" && lastName == "") {
                        svc.nameToDisplay = ""
                    }
                    else {
                        svc.nameToDisplay = firstName + " " + lastName
                    }
                }
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
}
