//
//  ImageRequest.swift
//  Marvel
//
//  Created by thales.garcia on 14/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class ImageRequest {
    private let network = Network()
    private var imageURL: String?
    
    init(imageURL: String?) {
        self.imageURL = imageURL
    }
    
    func request(completion: @escaping (Data?) -> Void) {
        guard let imageURL = self.imageURL, let url = URL(string: imageURL) else {
            completion(nil)
            return
        }
        
        network.downloadImage(url: url) { (imageData) in
            completion(imageData)
        }
    }
}
