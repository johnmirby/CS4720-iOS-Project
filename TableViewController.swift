//
//  TableViewController.swift
//  CS4720 iOS Project
//
//  Created by Kyle Eklund on 10/26/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
}