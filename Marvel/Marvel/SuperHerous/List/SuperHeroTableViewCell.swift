//
//  SuperHeroTableViewCell.swift
//  Marvel
//
//  Created by thales.garcia on 12/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

protocol SuperHeroTableViewCellDelegate: class {
    func favouriteSuperHero(superHero: SuperHeroDTO?, isFavourite: Bool)
}

class SuperHeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var imageDelegate: LoadImageDelegate?
    weak var delegate: SuperHeroTableViewCellDelegate?
    
    var superHero: SuperHeroDTO?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with superHero: SuperHeroDTO, isFavourite: Bool, completion: @escaping (UIImage?) -> Void) {
        self.superHero = superHero
        nameLabel.text = superHero.name
        selectFavouriteButton(isFavourite: isFavourite)
        
        thumbImageView.image = UIImage(named: "not-available")
        
        imageDelegate?.load(imageURL: superHero.thumb, completion: completion)
    }
    
    func setImage(_ image: UIImage?) {
        if let returnImage = image {
            self.thumbImageView.image = returnImage
        }
    }
    
    @IBAction func favouriteButtonDidTouch() {
        selectFavouriteButton(isFavourite: !favouriteButton.isSelected)
        delegate?.favouriteSuperHero(superHero: superHero, isFavourite: favouriteButton.isSelected)
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: Notification.Name.superHeroFavourite)))
    }
    
    private func selectFavouriteButton(isFavourite: Bool) {
        favouriteButton.isSelected = isFavourite
        
        let color = isFavourite ? UIColor.yellow : UIColor.white
        favouriteButton.backgroundColor = color
    }
}
