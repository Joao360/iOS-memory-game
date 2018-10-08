//
//  MapViewController.swift
//  sample
//
//  Created by João Graça on 02/10/2018.
//  Copyright © 2018 João Graça. All rights reserved.
//

import UIKit
import Contacts
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private let regionLatitudeMeters: CLLocationDistance = 400
    private let regionLongitudeMeters: CLLocationDistance = 400
    private var nearbies: [Nearby] = [
        Nearby(latitude: 40, longitude: -8),
        Nearby(latitude: 37, longitude: -10),
        Nearby(latitude: 40, longitude: -9)
    ]
    private let reuseIdentifier = "pin"
    
    enum CellIdentifiers: String {
        case single = "nearbySingleCell"
        case multiple = "nearbyMultipleCell"
    }
    
    @IBOutlet weak var nearbyCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate func addPlacemarks() {
        let coords = CLLocationCoordinate2DMake(38.736946, -9.142685)
//        let address = [CNPostalAddressStreetKey: "Avenida da Igreja", CNPostalAddressCityKey: "Lisbon", CNPostalAddressPostalCodeKey: "1600", CNPostalAddressISOCountryCodeKey: "PT"]
//        let place = MKPlacemark(coordinate: coords, addressDictionary: address)
//
//        map.addAnnotation(place)
        
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.pinCustomImageName = "My Pin"
        pointAnnotation.coordinate = coords
        pointAnnotation.title = "I'm a pin..."
        pointAnnotation.subtitle = "a custom pin"
        
        let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: reuseIdentifier)
        mapView.addAnnotation(pinAnnotationView.annotation!)
        
        for nearby in nearbies {
            let pointAnnot = CustomPointAnnotation()
            pointAnnot.pinCustomImageName = "My Pin"
            pointAnnot.coordinate = nearby.coordinates
            
            let pointAnnotView = MKPinAnnotationView(annotation: pointAnnot, reuseIdentifier: reuseIdentifier)
            mapView.addAnnotation(pointAnnotView.annotation!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearbyCollectionView.dataSource = self
        nearbyCollectionView.delegate = self
        
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        addPlacemarks()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        print("LocationManager \(location.coordinate)")
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionLatitudeMeters, longitudinalMeters: regionLongitudeMeters)
        //var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        //mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let mapCenter = mapView.centerCoordinate
        print("mapCenter - \(mapCenter)")
        nearbies.sort(by: { $0.coordinates.distance(to: mapCenter) < $1.coordinates.distance(to: mapCenter) })
        nearbyCollectionView.reloadData()
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
//
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
//            annotationView?.canShowCallout = true
//        } else {
//            annotationView?.annotation = annotation
//        }
//
//        let customPointAnnotation = annotation as! CustomPointAnnotation
//        annotationView?.image = UIImage(named: customPointAnnotation.pinCustomImageName)
//
//        return annotationView
//    }
}

extension MapViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let prototype = nearbies[indexPath.row]
        print("collectionView \(indexPath.row) - \(prototype.coordinates)")
        if prototype == Nearby(latitude: 37, longitude: -10) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.multiple.rawValue, for: indexPath)
            cell.backgroundColor = .black
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.single.rawValue, for: indexPath)
            
            cell.backgroundColor = .yellow
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nearby = nearbies[indexPath.row]
        let center = CLLocationCoordinate2D(latitude: nearby.coordinates.latitude, longitude: nearby.coordinates.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionLatitudeMeters, longitudinalMeters: regionLongitudeMeters)
        mapView.setRegion(region, animated: true)
    }
}

extension CLLocationCoordinate2D {
    func distance(to location: CLLocation) -> CLLocationDegrees {
        return abs(location.coordinate.latitude - self.latitude) + abs(location.coordinate.longitude - self.longitude)
    }
    
    func distance(to location: CLLocationCoordinate2D) -> CLLocationDegrees {
        return abs(location.latitude - self.latitude) + abs(location.longitude - self.longitude)
    }
}
