//
//  Serie.swift
//  Marvel
//
//  Created by thales.garcia on 16/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class Serie: Mappable, CollectionItem {
    
    var id: Int = 0
    var title: String = ""
    var thumb: Image?
    
    init(json: JSONDictionary) {
        id = json["id"] as? Int ?? 0
        title = json["title"] as? String ?? ""
        if let imageJSON = json["thumbnail"] as? JSONDictionary {
            thumb = Image(json: imageJSON)
        }
    }
}

