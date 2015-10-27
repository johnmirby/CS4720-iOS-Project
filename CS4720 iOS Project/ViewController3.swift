//
//  ViewController3.swift
//  CS4720 iOS Project
//
//  Created by Kyle Eklund on 10/26/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    
    let tableData = ["One","Two","Three"]
    var valueToPass:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "detailSegue"){
            if let svc = segue.destinationViewController as? ViewController4 {
                svc.nameToDisplay = valueToPass
            }
        }
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell")
        cell.textLabel?.text = tableData[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!;
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!;
        
        valueToPass = currentCell.textLabel!.text
        performSegueWithIdentifier("detailSegue", sender: self)
    }
}
