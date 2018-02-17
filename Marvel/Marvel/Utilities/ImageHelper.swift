//
//  ImageHelper.swift
//  Marvel
//
//  Created by thales.garcia on 16/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(fromURL URL: String?, completion: (() -> Void)? = nil) {
        ImageRequest(imageURL: URL).request { [weak self] (imageData) in
            guard let image = imageData, let imageObject = UIImage(data: image) else {
                completion?()
                return
            }
            DispatchQueue.main.async {
                self?.image = imageObject
                completion?()
            }
        }
    }
}
