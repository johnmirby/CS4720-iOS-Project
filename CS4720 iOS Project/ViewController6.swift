//
//  ViewController4.swift
//  CS4720 iOS Project
//
//  Created by Kyle Eklund on 10/27/15.
//  Copyright © 2015 John Irby. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController6: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate  {
    
    var locationManager: CLLocationManager?
    
    var nameToDisplay = ""
    var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    var imageVal:UIImage?
    var descriptionVal:String?
    var locationVal:CLLocation?
    
    @IBAction func updateMarkerLocation(sender: AnyObject) {
        let point = MKPointAnnotation()
        if (locationManager?.location != nil){
            point.coordinate = (locationManager?.location?.coordinate)!
            mapView.addAnnotation(point)
            centerMapOnLocation((locationManager?.location)!)
            locationVal = locationManager?.location
        }
        else {
            displayAlertWithTitle("No Current Location", message: "Please wait for the current location to be updated.")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count == 0{
            //handle error here
            return
        }
    }
    
    func locationManager(manager: CLLocationManager,
        didFailWithError error: NSError){
            print("Location manager failed with error = \(error)")
    }
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            
            print("The authorization status of location services is changed to: ", terminator: "")
            
            switch CLLocationManager.authorizationStatus(){
            case .AuthorizedAlways:
                print("Authorized")
            case .AuthorizedWhenInUse:
                print("Authorized when in use")
            case .Denied:
                print("Denied")
            case .NotDetermined:
                print("Not determined")
            case .Restricted:
                print("Restricted")
            }
            
    }
    
    func displayAlertWithTitle(title: String, message: String){
        let controller = UIAlertController(title: title,
            message: message,
            preferredStyle: .Alert)
        
        controller.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func createLocationManager(startImmediately startImmediately: Bool){
        locationManager = CLLocationManager()
        if let manager = locationManager{
            print("Successfully created the location manager")
            manager.delegate = self
            if startImmediately{
                manager.startUpdatingLocation()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .AuthorizedAlways:
                /* Yes, always */
                createLocationManager(startImmediately: true)
            case .AuthorizedWhenInUse:
                /* Yes, only when our app is in use */
                createLocationManager(startImmediately: true)
            case .Denied:
                /* No */
                displayAlertWithTitle("Not Determined",
                    message: "Location services are not allowed for this app")
            case .NotDetermined:
                /* We don't know yet, we have to ask */
                createLocationManager(startImmediately: false)
                if let manager = self.locationManager{
                    manager.requestWhenInUseAuthorization()
                }
            case .Restricted:
                /* Restrictions have been applied, we have no access
                to location services */
                displayAlertWithTitle("Restricted",
                    message: "Location services are not allowed for this app")
            }
            
            
        } else {
            /* Location services are not enabled.
            Take appropriate action: for instance, prompt the
            user to enable the location services */
            print("Location services are not enabled")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if (nameToDisplay == ""){
            label.text = "No item name"
        }
        else{
            label.text = nameToDisplay
        }
        
        // Set initial location to UVA
        let initialLocation = CLLocation(latitude: 38.0350, longitude: -78.5050)
        centerMapOnLocation(initialLocation)
        
        let imagePath = NSTemporaryDirectory() + nameToDisplay + "_image.png"
        let descriptionPath = NSTemporaryDirectory() + nameToDisplay + "_description.txt"
        let locationPath = NSTemporaryDirectory() + nameToDisplay + "_location.txt"
        do {
            imageVal = try UIImage(contentsOfFile: imagePath)

            //Update the image
            imageView.image = imageVal?.imageRotatedByDegrees(90, flip: false)
            
        } catch let error as NSError {
            print(error)
        }
        do {
            descriptionVal = try String(contentsOfFile: descriptionPath, encoding: NSUTF8StringEncoding)
            
            //Update the description
            descriptionLabel.text! = descriptionVal!
            
        } catch let error as NSError {
            print(error)
        }
        do {
            let readString = try String(contentsOfFile: locationPath, encoding: NSUTF8StringEncoding)
            var valuesArray = readString.componentsSeparatedByString(",")
            let lat = Double(valuesArray[0])
            let lon = Double(valuesArray[1])
            locationVal = CLLocation(latitude: lat!, longitude: lon!)
            
            //Update the mapView
            let point = MKPointAnnotation()
            point.coordinate = (locationVal?.coordinate)!
            mapView.addAnnotation(point)
            centerMapOnLocation(locationVal!)
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateDescription(sender: AnyObject) {
        descriptionLabel.text! = descriptionText.text!
        descriptionVal = descriptionText.text!
    }
    
    @IBAction func addImage(sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .Camera
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        else{
            let alertController = UIAlertController(title: "No Camera", message:
                "This device does not have a camera.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageVal = imageView.image
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (imageVal != nil){
            let path = NSTemporaryDirectory() + nameToDisplay + "_image.png"
            do {
                try UIImagePNGRepresentation(imageVal!)?.writeToFile(path, atomically: true)
            } catch let error as NSError {
                print(error)
            }
        }
        if (descriptionVal != nil){
            let path = NSTemporaryDirectory() + nameToDisplay + "_description.txt"
            do {
                try descriptionVal!.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
                
            } catch let error as NSError {
                print(error)
            }
        }
        if (locationVal != nil){
            let path = NSTemporaryDirectory() + nameToDisplay + "_location.txt"
            let locationString = (locationVal?.coordinate.latitude.description)! + "," + (locationVal?.coordinate.longitude.description)!
            do {
                try locationString.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
            } catch let error as NSError {
                print(error)
            }
        }
    }
}