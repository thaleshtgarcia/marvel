//
//  SuperHeroDetailTableViewCell.swift
//  Marvel
//
//  Created by thales.garcia on 16/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

protocol SuperHeroDetailTableViewCellDelegate: class {
    func favouriteSuperHero(superHero: SuperHeroDTO?, isFavourite: Bool)
}

class SuperHeroDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var delegate: SuperHeroDetailTableViewCellDelegate?
    var superHero: SuperHeroDetailDTO?
    
    func setup(superHero: SuperHeroDetailDTO, isFavourite: Bool) {
        self.superHero = superHero
        thumbImageView.image = UIImage(named: "not-available")
        thumbImageView.loadImage(fromURL: superHero.details?.thumb)
        
        infoLabel.text = superHero.details?.name
        
        descriptionLabel.text = "No description available"
        if let description = superHero.details?.heroDescription, !description.isEmpty {
            descriptionLabel.text = description
        }
        selectFavouriteButton(isFavourite: isFavourite)
        
    }
    
    @IBAction func favouriteButtonDidTouch() {
        selectFavouriteButton(isFavourite: !favouriteButton.isSelected)
        delegate?.favouriteSuperHero(superHero: superHero?.details, isFavourite: favouriteButton.isSelected)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: Notification.Name.superHeroFavourite)))
    }
    
    private func selectFavouriteButton(isFavourite: Bool) {
        favouriteButton.isSelected = isFavourite
        
        let color = isFavourite ? UIColor.yellow : UIColor.white
        favouriteButton.backgroundColor = color
    }
}
