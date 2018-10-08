//
//  Nearby.swift
//  sample
//
//  Created by João Graça on 08/10/2018.
//  Copyright © 2018 João Graça. All rights reserved.
//

import Foundation
import MapKit

struct Nearby: Equatable {
    static func == (lhs: Nearby, rhs: Nearby) -> Bool {
        return lhs.coordinates.latitude == rhs.coordinates.latitude && lhs.coordinates.longitude == rhs.coordinates.longitude
    }
    
    let coordinates: CLLocationCoordinate2D
    let imgURL: URL
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, imgURL: String) {
        coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.imgURL = URL(string: imgURL)!
    }
}
