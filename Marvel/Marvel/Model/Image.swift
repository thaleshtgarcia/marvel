//
//  Image.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

enum ImageConfiguration {
    
    enum Position: String {
        case portrait = "portrait"
        case standart = "standart"
        case landscape = "landscape"
        
        
    }
    enum Size: String {
        case small = "small"
        case medium = "medium"
        case xlarge = "xlarge"
        case fantastic = "fantastic"
        case uncanny = "uncanny"
        case incredible = "incredible"
        
    }
    
    case aspectRatio(position: Position, size: Size)
    
    func value() -> String {
        switch self {
        case let .aspectRatio(position, size):
            return position.rawValue + "_" + size.rawValue
        }
    }
}

class Image: Mappable {
    var path: String = ""
    var imageExtension: String = ""
    var imageConfiguration: ImageConfiguration = .aspectRatio(position: .portrait, size: .small)
    
    var fullPath: String {
        return path+"/portrait_xlarge."+imageExtension
    }
    
    init(json: JSONDictionary) {
        path = json["path"] as? String ?? ""
        imageExtension = json["extension"] as? String ?? ""
    }
    
    fileprivate enum CodingKeys: String, CodingKey {
        case path = "path"
        case imageExtension = "extension"
    }
}
