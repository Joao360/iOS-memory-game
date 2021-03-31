//
//  NeabySingleCell.swift
//  sample
//
//  Created by João Graça on 08/10/2018.
//  Copyright © 2018 João Graça. All rights reserved.
//

import UIKit

class NearbySingleCell: UICollectionViewCell {
    
    let image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
