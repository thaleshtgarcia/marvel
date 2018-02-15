//
//  Image.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class Image: Mappable {
    var path: String = ""
    var imageExtension: String = ""
    
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
