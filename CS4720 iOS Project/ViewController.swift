//
//  ViewController.swift
//  CS4720 iOS Project
//
//  Created by David Irby on 10/16/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func setText(sender: UIButton) {
        label.text = editText.text
    }

}

