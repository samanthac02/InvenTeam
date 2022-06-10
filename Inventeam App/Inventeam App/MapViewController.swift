//
//  MapViewController.swift
//  Inventeam App
//
//  Created by Samantha Chang on 9/21/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate  {
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var mapView: MKMapView!
    let myLocation = CLLocation(latitude: 33.866340, longitude: -118.255070)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        centerMapOnLocation(myLocation, mapView: mapView)
    }

    @IBAction func onButton(_ sender: Any) {
        print("something")
        let url=URL(string: "http://192.168.4.1/led/1")
        let urlreq=URLRequest(url: url!)
        self.web.loadRequest(urlreq)
    }
    
    @IBAction func offButton(_ sender: Any) {
        let url=URL(string: "http://192.168.4.1/led/0")
        let urlreq=URLRequest(url: url!)
        self.web.loadRequest(urlreq)
    }
    
    var locationManager: CLLocationManager!
    var currentLocationStr = "Current location"
    let annotation = MKPointAnnotation()
    

    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)

        // Get user's Current Location and Drop a pin
        let annotation: MKPointAnnotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        annotation.title = self.setUsersClosestLocation(mLattitude: userLocation.coordinate.latitude, mLongitude: userLocation.coordinate.longitude)
        mapView.addAnnotation(annotation)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }

    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in

            if let placemark = placemarks{
                if let dict = placemark[0].addressDictionary as? [String: Any]{
                    if let Name = dict["Name"] as? String{
                        if let City = dict["City"] as? String{
                            self.currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }
    
    func centerMapOnLocation(_ location: CLLocation, mapView: MKMapView) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
