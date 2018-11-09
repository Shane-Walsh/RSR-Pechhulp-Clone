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

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    //From Allen Sean Tutorial
    let locationManager = CLLocationManager()
    
    let newPin = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }

    
    //From Allen Sean Tutorial
   // func checkLocationServices(){
        
   //     if CLLocationManager.locationServicesEnabled(){
            //locationManager setup
            
   //     }else {
   //         //alert user to switch locationServices on
            
   //     }
   // }
    //From Allen Sean Tutorial
    //func setupLocationManager(){
        
    //}
    
}

//https://www.thorntech.com/2016/01/how-to-search-for-location-using-apples-mapkit/
//https://www.ioscreator.com/tutorials/mapkit-ios-tutorial-ios10


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    // WORKING ;)
    //https://stackoverflow.com/questions/46107036/thread-1-exc-breakpoint-code-1-subcode-0x10039fb00
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        mapView.removeAnnotation(newPin)
        
        if let location = locations.first {
            
            print("location:: \(location)")
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            //https://stackoverflow.com/questions/40894722/swift-mkmapview-drop-a-pin-annotation-to-current-location
            newPin.coordinate = location.coordinate
            mapView.addAnnotation(newPin)

        }
    }
}


//From Allen Sean Tutorial
//https://www.youtube.com/watch?v=WPpaAy73nJc
//extension MapViewController: CLLocationManagerDelegate{
//
//    func locationManager(_manager: CLLocationManager, didUpdatelocations locations: [CLLocation]){
//
//    }
//}


