//
//  CollectionTableViewCell.swift
//  Marvel
//
//  Created by thales.garcia on 17/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: LoadImageDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(with item: CollectionItem) {
        titleLabel.text = item.title
        descriptionLabel.text = ""
        thumbImageView.image = UIImage(named: "not-available")
        thumbImageView.loadImage(fromURL: item.thumb?.fullPath)
    }
}

