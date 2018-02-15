//
//  SuperHeroTableViewCell.swift
//  Marvel
//
//  Created by thales.garcia on 12/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

protocol SuperHeroTableViewCellDelegate: class { 
    func load(imageURL: String?, completion: @escaping (UIImage?) -> Void) 
}
class SuperHeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: SuperHeroTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with superHero: SuperHeroDTO) {
        
        thumbImageView.image = UIImage(named: "not-available")
        delegate?.load(imageURL: superHero.thumb) { image in
            DispatchQueue.main.async { [weak self] in 
                if let returnImage = image {
                    self?.thumbImageView.image = returnImage
                }
            }
        }

        nameLabel.text = superHero.name
        descriptionLabel.text = superHero.description
    }
        
}

