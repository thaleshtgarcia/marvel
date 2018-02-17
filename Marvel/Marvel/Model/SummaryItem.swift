//
//  SummaryItem.swift
//  Marvel
//
//  Created by thales.garcia on 16/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class SummaryItem: Mappable {
    
    var resourceURI: String = ""
    var name: String = ""
    
    
    init(json: JSONDictionary) {
        resourceURI = json["resourceURI"] as? String ?? ""
        name = json["name"] as? String ?? ""
    }
}

