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
    
    @IBOutlet var calloutView: UIView!
    
    @IBOutlet weak var callNowButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    let newPin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Implement locationManager delegate protocol
        locationManager.delegate = self
        
        //Implement mapView delegate protocol
        mapView.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Ask permission to access user location
        locationManager.requestWhenInUseAuthorization()
        
        // Request current location
        locationManager.requestLocation()
        
        callNowView.isHidden = true
        
    }
    
    //MARK: Button Action
    @IBAction func callNowButton(button: UIButton) {
    
        callNowView.isHidden = false
        print("Button Pressed")
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      
        mapView.removeAnnotation(newPin)
        
        if let location = locations.first {
            
            print("location:: \(location)")
            
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
     
            newPin.title = "Uw locatie"
            newPin.coordinate = location.coordinate
            mapView.addAnnotation(newPin)
        }
        
    }
}

extension MapViewController: MKMapViewDelegate {
    ////http://swiftdeveloperblog.com/code-examples/mkannotationview-display-custom-pin-image/
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        // To identify annotation in the queue
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        // If none in queue, create new annotation
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            
            annotationView!.isEnabled = true
            annotationView!.image = UIImage(named: "marker")
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
//https://digitalleaves.com/blog/2016/12/building-the-perfect-ios-map-ii-completely-custom-annotation-views
//addSubview(UIImageView(image: UIImage(named: "car")))

// CHECK THIS LINK FOR CALLOUT ANNOTATION
// https://www.hackingwithswift.com/read/19/2/up-and-running-with-mapkit       <-----
// https://stackoverflow.com/questions/48421167/map-annotation-callout-title
// https://github.com/codepath/ios_guides/wiki/Using-MapKit
// http://sweettutos.com/2016/01/21/swift-mapkit-tutorial-series-how-to-customize-the-map-annotations-callout-request-a-transit-eta-and-launch-the-transit-directions-to-your-destination/
// http://sweettutos.com/2016/03/16/how-to-completely-customise-your-map-annotations-callout-views/
// https://stackoverflow.com/questions/44815487/creating-a-custom-map-annotation-callout-with-an-image-accessing-data-from-an-a
// https://makeapppie.com/2016/05/16/adding-annotations-and-overlays-to-maps/
// https://www.raywenderlich.com/548-mapkit-tutorial-getting-started
// https://www.raywenderlich.com/425-mapkit-tutorial-overlay-views
// https://stackoverflow.com/questions/40894722/swift-mkmapview-drop-a-pin-annotation-to-current-location
//          ---><---
// https://www.surekhatech.com/blog/custom-callout-view-for-ios-map
// http://www.ericmentele.com/blog/a-simple-custom-map-annotation-callout-view-with-multi-colored-text-in-swift
// http://bcdilumonline.blogspot.com/2014/10/adding-custom-annotationview-with.html
// annotationView?.addSubview(UIImageView(image: UIImage(named: "address")))
// Next Steps!!
// https://www.youtube.com/results?search_query=Custom+View+iOS+2018
// https://github.com/Jeyamahesan/CustomMapCallout/blob/master/MapViewSample/ViewController.swift
// https://stackoverflow.com/questions/40106954/custom-callout-view-with-xib
// https://www.appcoda.com/mapkit-beginner-guide/  <-- good explanations for comments
// https://iostutorialbyani.blogspot.com/2016/08/custom-map-annotation-pin-in-swift.html
// ---------------
// https://www.thorntech.com/2016/01/how-to-search-for-location-using-apples-mapkit/  <-- Placemarks
// https://www.ioscreator.com/tutorials/mapkit-ios-tutorial-ios10
// https://makeapppie.com/2018/02/20/use-markers-instead-of-pins-for-map-annotations/
// ------ UI View --------
// https://medium.com/@ludovicjamet/how-to-use-storyboard-to-create-and-preview-custom-views-92acad7405fa
