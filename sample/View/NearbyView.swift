//
//  MapView.swift
//  sample
//
//  Created by João Graça on 09/10/2018.
//  Copyright © 2018 João Graça. All rights reserved.
//

import UIKit
import MapKit

class NearbyView: UIView {
    
    lazy var nearbyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 50, height: 50)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(NearbySingleCell.self, forCellWithReuseIdentifier: CellIdentifiers.single.rawValue)
        collectionView.register(NearbyMultipleCell.self, forCellWithReuseIdentifier: CellIdentifiers.multiple.rawValue)
        return collectionView
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    func loadView() {
        self.backgroundColor = .white
        self.addSubview(nearbyCollectionView)
        self.addSubview(mapView)
        setupLayout()
    }

    private func setupLayout() {
        nearbyCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        nearbyCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        nearbyCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        nearbyCollectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        mapView.topAnchor.constraint(equalTo: nearbyCollectionView.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

}
