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
    
    override func viewWillAppear(animated: Bool) {
        self.submitScore()
        self.retrieveScores()
    }
    
    func submitScore() {
        var fullName = ""
        var totalScore = 0
        do {
            let path = NSTemporaryDirectory() + "userInfo.txt"
            let readString = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            var valuesArray = readString.componentsSeparatedByString(",")
            fullName = valuesArray[0] + "%20" + valuesArray[1]
        } catch let error as NSError {
            print(error)
        }
        do {
            let path = NSTemporaryDirectory() + "totalScore.txt"
            let readString = try String(contentsOfFile: path)
            totalScore = Int(readString)!
        } catch let error as NSError {
            print(error)
        }
        if (!fullName.isEmpty){
            let urlPath = "http://dreamlo.com/lb/" + dreamloPrivate + "/add/" + fullName + "/" + totalScore.description
            guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint"); return }
            let request = NSMutableURLRequest(URL: endpoint)
            NSURLSession.sharedSession().dataTaskWithRequest(request).resume()
        }
    }
        
    func retrieveScores() {
        let urlPath = "http://dreamlo.com/lb/" + dreamloPublic + "/json"
        guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint"); return }
        let request = NSMutableURLRequest(URL: endpoint)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                
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
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                });
                
            } catch let error as JSONError {
                self.tableData.append("Could not load scores")
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                });
                print(error.rawValue)
            } catch {
                self.tableData.append("Could not load scores")
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                });
                print(error)
            }
        }.resume()
    }
        
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
}