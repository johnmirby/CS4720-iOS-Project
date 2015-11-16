//
//  ViewController7.swift
//  UVA Bucket List
//
//  Created by John Irby on 11/16/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit

class ViewController7: UIViewController {
    
    let dreamloPrivate = "QvOwrk2eEUyodUOdyWDHhQiHmXZ8tK_kWP1D4O_hmHwQ"
    let dreamloPublic = "564a5d406e51b612c8e258e5"
    
    var tableData = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
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
    }
    
    override func viewDidLoad() {
        retrieveScores()
    }
    
        
    func retrieveScores() {
        let urlPath = "http://dreamlo.com/lb/" + dreamloPublic + "/json"
        guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint"); return }
        let request = NSMutableURLRequest(URL: endpoint)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                
                //TODO: Parse JSON and insert into TableData
                if let dreamlo = json["dreamlo"] as? NSDictionary {
                    if let leaderboard = dreamlo["leaderboard"] as? NSDictionary {
                        if let entries = leaderboard["entry"] as? NSArray {
                            for entry in entries {
                                if let entry = entry as? NSDictionary {
                                    if let name = entry["name"] as? String {
                                        if let score = entry["score"] as? String {
                                            self.tableData.append(name + ": " + score)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                self.tableView.reloadData()
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch {
                print(error)
            }
        }.resume()
    }
        
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
}