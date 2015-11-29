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

class ViewController4: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate  {
    
    let dreamloPrivate = "QvOwrk2eEUyodUOdyWDHhQiHmXZ8tK_kWP1D4O_hmHwQ"
    let dreamloPublic = "564a5d406e51b612c8e258e5"
    
    var locationManager: CLLocationManager?
    
    var bucketListNum = 0;
    
    var nameToDisplay = ""
    var index = 0
    var imagePicker: UIImagePickerController!
    var completedStatus = Array(count: 116, repeatedValue: "1")
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    var imageVal:UIImage?
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
        
        do {
            let path = NSTemporaryDirectory() + "totalScore.txt"
            let readString = try String(contentsOfFile: path)
            bucketListNum = Int(readString)!
        } catch let error as NSError {
            print(error)
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
            descriptionText.text! = try String(contentsOfFile: descriptionPath, encoding: NSUTF8StringEncoding)
            
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
        do {
            let path = NSTemporaryDirectory() + "completedStatus.txt"
            let readString = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            completedStatus = readString.componentsSeparatedByString("\n")
        } catch let error as NSError {
            print(error)
        }
        segmentedControl.selectedSegmentIndex = Int(completedStatus[index])!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedControlIndexChanged(sender: AnyObject) {
        if (segmentedControl.selectedSegmentIndex == 0){
            bucketListNum++
        }
        else {
            bucketListNum--
        }
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
    
    @IBAction func saveListItem(sender: AnyObject) {
        if (imageVal != nil){
            let path = NSTemporaryDirectory() + nameToDisplay + "_image.png"
            do {
                try UIImagePNGRepresentation(imageVal!)?.writeToFile(path, atomically: true)
            } catch let error as NSError {
                print(error)
            }
        }
        if (!descriptionText.text!.isEmpty){
            let path = NSTemporaryDirectory() + nameToDisplay + "_description.txt"
            do {
                try descriptionText.text!.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
                
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
        completedStatus[index] = segmentedControl.selectedSegmentIndex.description
        do {
            let path = NSTemporaryDirectory() + "completedStatus.txt"
            let readString = completedStatus.joinWithSeparator("\n")
            try readString.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error)
        }
        
        do {
            let path = NSTemporaryDirectory() + "totalScore.txt"
            let writeString = bucketListNum.description
            try writeString.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
        } catch let error as NSError {
            print(error)
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.submitScore()
        });
        
        if let navigationController = self.navigationController{
            navigationController.popViewControllerAnimated(true)
        }
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
}

extension UIImage {
    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        let radiansToDegrees: (CGFloat) -> CGFloat = {
            return $0 * (180.0 / CGFloat(M_PI))
        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPointZero, size: size))
        let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        CGContextRotateCTM(bitmap, degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        CGContextScaleCTM(bitmap, yFlip, -1.0)
        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
