//
//  NearbyMultipleCell.swift
//  sample
//
//  Created by João Graça on 04/10/2018.
//  Copyright © 2018 João Graça. All rights reserved.
//

import Foundation
import UIKit

class NearbyMultipleCell: UICollectionViewCell {
    let topLeftImage = UIImageView()
    let topRightImage = UIImageView()
    let bottomLeftImage = UIImageView()
    let bottomRightImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topLeftImage)
        addSubview(topRightImage)
        addSubview(bottomLeftImage)
        addSubview(bottomRightImage)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        topLeftImage.translatesAutoresizingMaskIntoConstraints = false
        topRightImage.translatesAutoresizingMaskIntoConstraints = false
        bottomLeftImage.translatesAutoresizingMaskIntoConstraints = false
        bottomRightImage.translatesAutoresizingMaskIntoConstraints = false
        
        topLeftImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topLeftImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topLeftImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        topLeftImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        bottomLeftImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        bottomLeftImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        bottomLeftImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomLeftImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        topRightImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topRightImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        topRightImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        topRightImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        bottomRightImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        bottomRightImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        bottomRightImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomRightImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
