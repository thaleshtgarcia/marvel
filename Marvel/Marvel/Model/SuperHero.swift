//
//  SuperHero.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class SuperHero: Mappable {
    var id: Int = 0
    var name: String = ""
    var heroDescription: String = ""
    var thumb: Image?
    
    init(json: JSONDictionary) {
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        heroDescription = json["description"] as? String ?? ""
        
        if let imageJSON = json["thumbnail"] as? JSONDictionary {
            thumb = Image(json: imageJSON)
        }
    }
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id, name
        case heroDescription = "description"
        case thumb = "thumbnail"
    }
}
