//
//  SuperHeroTableViewCell.swift
//  Marvel
//
//  Created by thales.garcia on 12/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

class SuperHeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: LoadImageDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with superHero: SuperHeroDTO, completion: @escaping (UIImage?) -> Void) {
        
        nameLabel.text = superHero.name
        thumbImageView.image = UIImage(named: "not-available")
        
        delegate?.load(imageURL: superHero.thumb, completion: completion) 
    }
    
    func setImage(_ image: UIImage?) {
        if let returnImage = image {
            self.thumbImageView.image = returnImage
        }
    }
        
}

