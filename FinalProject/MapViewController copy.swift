//
//  MapViewController.swift
//  FinalProject
//
//  Created by Berry on 3/4/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    private var currCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLocationServices()
        

//        let initialLocation = CLLocation(latitude: 41.8781, longitude: -87.631)
//        let regionRadius: CLLocationDistance = 10000
//        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
//                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
//        mapView.setRegion(coordinateRegion, animated: true)
//        
//        // Add annotations (spots) to the map
//        let spot1 = CustomAnnotation(title: "Spot 1", subtitle: "Description of spot 1", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
//        let spot2 = CustomAnnotation(title: "Spot 2", subtitle: "Description of spot 2", coordinate: CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4194))
        for location in locations {
            mapView.addAnnotation(CustomAnnotation(title: location.name, subtitle: location.contact, coordinate: CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longtitude)!)))
        }
//        mapView.addAnnotations([spot1])
    }
    
    private func configLocationServices() {
        locationManager.delegate = self
        
        let status = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: locationManager)
        }
    }
    
    private func zoomToLatestLocation(with coordanate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordanate, latitudinalMeters: 10000, longitudinalMeters: 10000 )
        mapView.setRegion(region, animated: true)
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        let identifier = "customAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }

}



class CustomAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        print("Did get latest location")
        guard let lastLocation = locations.first else {
            return
        }
        
        if currCoordinate == nil {
            zoomToLatestLocation(with: lastLocation.coordinate)
        }
        
        currCoordinate = lastLocation.coordinate
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Status location change")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdates(locationManager: manager)
        }
    }
}
