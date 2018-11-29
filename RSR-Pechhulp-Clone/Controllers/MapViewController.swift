//
//  MapViewController.swift
//  RSR-Pechhulp-Clone
//
//  Created by Shane Walsh on 18/10/2018.
//  Copyright © 2018 Shane Walsh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var callNowView: UIView!
    
    @IBOutlet weak var customCallout: UIView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var callNowButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var callNumberButton: UIButton!
    
    @IBOutlet weak var bottomCallView: UIView!
    
    let locationManager = CLLocationManager()        // Access location manager API
    
    let mapMarker = MKPointAnnotation()              // Access annotation API
    
    let phoneNumber = "TEL://+31880016700"           // Set phone number for RSR
    
    static let geoCoder = CLGeocoder()               // Needed to convert coordinates into placenames
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkConnectivity()                                             // Check network connection & GPS
        
        //MARK: Initialise Views
        
        if UIDevice.current.userInterfaceIdiom == .pad {                // If iPad - hide call now button, otherwise hide bottom call panel
            
            callNowButton.isHidden = true
            
        } else {
        
            bottomCallView.isHidden = true
        }
        
        callNowView.isHidden = true                                     // Hide CallNow panel
        customCallout.isHidden = true                                   // Hide CallOut bubble
        
        mapView.delegate = self                                         // Implement mapView delegate protocol
        
        locationManager.delegate = self                                 // Implement locationManager delegate protocol
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest       // Set location accuracy
        
        locationManager.requestWhenInUseAuthorization()                 // Ask permission to access user location
        
        locationManager.startUpdatingLocation()                         // Get users current location
        
    }
    
    //MARK: Button Action
    @IBAction func callNowButton(button: UIButton) {
    
        callNowView.isHidden = false                                    // Shows callNow panel on button tap
        customCallout.isHidden = true                                    // Hide callout bubble
    }
    
    @IBAction func cancelButton(button: UIButton) {
        
        customCallout.isHidden = false                                  // Callout bubble reappears if user cancels
        callNowView.isHidden = true                                     // Hide CallNow panel
    }
    
    @IBAction func callPhoneNumber(button: UIButton) {
        
        // Ask device to call phone number
        let url: NSURL = URL(string: phoneNumber)! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
    // Display user address in callout bubble
    func displayAddress(with location: CLLocation){
        
        // Get user location corrdinates
        let address = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        
        // Convert coordinates to placemarks ie. address
        MapViewController.geoCoder.reverseGeocodeLocation(address) {
            (placemarks, error) -> Void in
            if let placemarks = placemarks, placemarks.count > 0 {
                let placemark = placemarks[0]
                
                var addressString : String = ""
                
                // First check if placemarks exist
                if placemark.thoroughfare != nil {
                    addressString = addressString + placemark.thoroughfare! + ", "
                }
                if placemark.subThoroughfare != nil {
                    addressString = addressString + placemark.subThoroughfare! + "\n"
                }
                if placemark.postalCode != nil {
                    addressString = addressString + placemark.postalCode! + ", "
                }
                if placemark.locality != nil {
                    addressString = addressString + placemark.locality!
                }

               self.addressLabel.text = String(addressString)
            }
        }
    }
    
    
    // MARK: Connectivity Check
    
    func checkConnectivity() {
        
        // Check for internet connection
        if !Reachability.shared.isConnectedToNetwork(){
            
            self.showAlert(title: "No internet connection", msg: "Make sure your device is connected to the internet", actions: nil)
        }
        
        // Check for GPS
       if !CLLocationManager.locationServicesEnabled() {
            
            self.showAlert(title: "No GPS connection", msg: "Make sure GPS is switched on to continue", actions: nil)
        }
    }
    
    // Alert user
    func showAlert(title: String, msg: String, actions:[UIAlertAction]?) {
        
        var actions = actions
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        if actions == nil {
            actions = [UIAlertAction(title: "OK", style: .default, handler: nil)]
        }
        
        for action in actions! {
            alertVC.addAction(action)
        }
        
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            rootVC.present(alertVC, animated: true, completion: nil)
        } else {
            print("Error: Root view controller not set.")
        }
    }
}


//MARK: Location Services

extension MapViewController: CLLocationManagerDelegate {
    
    // Respond to potential errors regarding location services
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    // Check whether authorized to get current location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        if let location = locations.first {
            
            print("location:: \(location)")
            
            // Set region to map and zoom to location
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
     
            mapMarker.coordinate = location.coordinate
            mapView.addAnnotation(mapMarker)
            
            self.displayAddress(with: location)                // Send coordinates to displayAddress method
            locationManager.stopUpdatingLocation()             // Stop the generation of updates (user location)
        }
    }
}


//MARK: MapView Delegate

extension MapViewController: MKMapViewDelegate {
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationIdentifier")
        
        annotationView.image = UIImage(named: "marker")
        
        customCallout.isHidden = false          // Show annotation
        
        // Frame callout bubble above annotation
        customCallout.frame = CGRect(x: -(customCallout.frame.width  / 2), y: -(customCallout.frame.height), width: customCallout.frame.width, height: customCallout.frame.height)
        
        annotationView.addSubview(customCallout)
        
        return annotationView
    }
}
