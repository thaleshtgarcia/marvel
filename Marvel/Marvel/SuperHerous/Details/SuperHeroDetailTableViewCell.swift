//
//  SuperHeroDetailTableViewCell.swift
//  Marvel
//
//  Created by thales.garcia on 16/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

class SuperHeroDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup(superHero: SuperHeroDetailDTO) {
        thumbImageView.image = UIImage(named: "not-available")
        thumbImageView.loadImage(fromURL: superHero.details?.thumb)
        
        infoLabel.text = superHero.details?.name
        descriptionLabel.text = "No description available"
    }
    
//    func setImage(_ image: UIImage?) {
//        if let returnImage = image {
//            self.thumbImageView.image = returnImage
//        }
//    }
}
