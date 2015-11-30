//
//  ViewController5.swift
//  CS4720 iOS Project
//
//  Created by Kyle Eklund on 11/2/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit

class ViewController5: UIViewController {
    
    var tableData = [String]()
    var valueToPass:String!
    var indexToPass:Int!
    var emptyList = false
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let path = NSTemporaryDirectory() + "customList.txt"
        do {
            let readString = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            if (readString.isEmpty) {
                tableData = [String]()
            }
            else {
                tableData = readString.componentsSeparatedByString("\n")
            }
        } catch let error as NSError {
            print(error)
        }
        
        if (tableData.count == 0){
            tableData.append("No Custom List Items")
            emptyList = true
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "customDetailSegue"){
            if let svc = segue.destinationViewController as? ViewController6 {
                svc.nameToDisplay = valueToPass
                svc.index = indexToPass
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
        if (currentCell.textLabel!.text != "No Custom List Items"){
            valueToPass = currentCell.textLabel!.text
            indexToPass = indexPath.row
            performSegueWithIdentifier("customDetailSegue", sender: self)
        }
    }
    
    @IBAction func addItem(sender: AnyObject) {
        if (emptyList){
            tableData[0] = String(tableData.count) + ". " + textField.text! as String!
            tableView.reloadData()
            emptyList = false
        }
        else {
            tableData.append(String(tableData.count + 1) + ". " + textField.text! as String!)
            tableView.reloadData()
            emptyList = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (!emptyList){
            let path = NSTemporaryDirectory() + "customList.txt"
            let joined = tableData.joinWithSeparator("\n")
            do {
                try joined.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
