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
import Kingfisher

enum CellIdentifiers: String {
    case single = "nearbySingleCell"
    case multiple = "nearbyMultipleCell"
}

class NearbyViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private let regionLatitudeMeters: CLLocationDistance = 400
    private let regionLongitudeMeters: CLLocationDistance = 400
    private var nearbies: [Nearby] = [
        Nearby(latitude: 40, longitude: -8, imgURL: "https://cdn1.iconfinder.com/data/icons/business-users/512/circle-512.png"),
        Nearby(latitude: 37, longitude: -10, imgURL: "https://cdn4.iconfinder.com/data/icons/user-15/164/3-512.png"),
        Nearby(latitude: 40, longitude: -9, imgURL: "https://image.flaticon.com/icons/png/512/17/17115.png")
    ]
    private let reuseIdentifier = "pin"
    private let nearbyView = NearbyView()
    
    override func loadView() {
        super.loadView()
        nearbyView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nearbyView)
        nearbyView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nearbyView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        nearbyView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        nearbyView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        nearbyView.loadView()
        
        view.backgroundColor = .yellow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearbyView.nearbyCollectionView.dataSource = self
        nearbyView.nearbyCollectionView.delegate = self
        
        nearbyView.mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        addPlacemarks()
    }
    
    fileprivate func addPlacemarks() {
        for nearby in nearbies {
            let pointAnnotation = CustomPointAnnotation()
            pointAnnotation.imgURL = nearby.imgURL
            pointAnnotation.coordinate = nearby.coordinates
            
            let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: reuseIdentifier)
            nearbyView.mapView.addAnnotation(pinAnnotationView.annotation!)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        print("LocationManager \(location.coordinate)")
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionLatitudeMeters, longitudinalMeters: regionLongitudeMeters)
        //var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        //nearbyView.mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let mapCenter = mapView.centerCoordinate
        print("mapCenter - \(mapCenter)")
        nearbies.sort(by: { $0.coordinates.distance(to: mapCenter) < $1.coordinates.distance(to: mapCenter) })
        nearbyView.nearbyCollectionView.reloadData()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        let customPointAnnotation = annotation as! CustomPointAnnotation
        KingfisherManager.shared.retrieveImage(with: customPointAnnotation.imgURL, options: nil, progressBlock: nil, completionHandler: { (image, error, type, url) in
            let size = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(size)
            image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            
            annotationView?.image = resizedImage
        })
        return annotationView
    }
}

extension NearbyViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbies.count
    }
    
    //TODO: Multithreading not treated right!
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let prototype = nearbies[indexPath.row]
        print("collectionView \(indexPath.row) - \(prototype.coordinates)")
        if prototype.coordinates.latitude == 37 && prototype.coordinates.longitude == -10 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.multiple.rawValue, for: indexPath) as! NearbyMultipleCell
        
            cell.topLeftImage.kf.indicatorType = .activity
            cell.topLeftImage.kf.setImage(with: prototype.imgURL)
            cell.topRightImage.kf.indicatorType = .activity
            cell.topRightImage.kf.setImage(with: prototype.imgURL)
            cell.bottomLeftImage.kf.indicatorType = .activity
            cell.bottomLeftImage.kf.setImage(with: prototype.imgURL)
            cell.bottomRightImage.kf.indicatorType = .activity
            cell.bottomRightImage.kf.setImage(with: prototype.imgURL)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.single.rawValue, for: indexPath) as! NearbySingleCell
            
            cell.image.kf.indicatorType = .activity
            cell.image.kf.setImage(with: prototype.imgURL)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nearby = nearbies[indexPath.row]
        let center = CLLocationCoordinate2D(latitude: nearby.coordinates.latitude, longitude: nearby.coordinates.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionLatitudeMeters, longitudinalMeters: regionLongitudeMeters)
        nearbyView.mapView.setRegion(region, animated: true)
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
