//
//  ViewController4.swift
//  CS4720 iOS Project
//
//  Created by Kyle Eklund on 10/27/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
    
    var nameToDisplay = ""
    
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (nameToDisplay == ""){
            label.text = "No item name"
        }
        else{
            label.text = nameToDisplay
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
