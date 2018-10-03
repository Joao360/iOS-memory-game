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

class MapViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let coords = CLLocationCoordinate2DMake(38.736946, -9.142685)
        
        let address = [CNPostalAddressStreetKey: "Avenida da Igreja", CNPostalAddressCityKey: "Lisbon", CNPostalAddressPostalCodeKey: "1600", CNPostalAddressISOCountryCodeKey: "PT"]
        
        let place = MKPlacemark(coordinate: coords, addressDictionary: address)
        
        map.addAnnotation(place)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
