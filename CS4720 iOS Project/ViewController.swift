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
    
    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set welcome message from user info name
        if (nameToDisplay == ""){
            welcomeLabel.text = "No user info entered."
        }
        else{
            welcomeLabel.text = "Welcome " + nameToDisplay + "!"
        }
        
        // set initial location in UVA
        let initialLocation = CLLocation(latitude: 38.0350, longitude: -78.5050)
        centerMapOnLocation(initialLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func setText(sender: UIButton) {
        label.text = editText.text
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 38.0350, longitude: -78.5050)
        point.title = "University of Virginia"
        mapView.addAnnotation(point)
    }
}

