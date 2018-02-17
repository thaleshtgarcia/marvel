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
    var comics: [SummaryItem]?
    var events: [SummaryItem]?
    var stories: [SummaryItem]?
    var series: [SummaryItem]?
    
    init(json: JSONDictionary) {
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        heroDescription = json["description"] as? String ?? ""
        
        if let comicsJSON = json["comics"] as? JSONDictionary {
            comics = parseSummaryItems(json: comicsJSON)
        }
        
        if let eventsJSON = json["events"] as? JSONDictionary {
            events = parseSummaryItems(json: eventsJSON)
        }
        
        if let storiesJSON = json["stories"] as? JSONDictionary {
            stories = parseSummaryItems(json: storiesJSON)
        }
        
        if let seriesJSON = json["series"] as? JSONDictionary {
            series = parseSummaryItems(json: seriesJSON)
        }
        
        if let imageJSON = json["thumbnail"] as? JSONDictionary {
            thumb = Image(json: imageJSON)
        }
    }
    
    private func parseSummaryItems(json: JSONDictionary) -> [SummaryItem]? {
    
        var objects: [SummaryItem] = []
        if let items = json["items"] as? [JSONDictionary] {
            for itemJSON in items {
                objects.append(SummaryItem(json: itemJSON))
            }
        }
        return objects.isEmpty ? nil : objects
    }
    
    fileprivate enum CodingKeys: String, CodingKey {
        case id, name
        case heroDescription = "description"
        case thumb = "thumbnail"
        case comics, events, stories, series
    }
}
