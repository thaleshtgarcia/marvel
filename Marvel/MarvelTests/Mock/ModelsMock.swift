//
//  ModelsMock.swift
//  MarvelTests
//
//  Created by thales.garcia on 19/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

@testable import Marvel

struct ComicMock {
    
    let id: Int = 62304
    let title: String = "Spider-Man: 101 Ways to End the Clone Saga (1997) #1"
    let thumb_path: String = "http://i.annihil.us/u/prod/marvel/i/mg/9/80/59b3104f67eaf"
    let thumb_extension: String = "jpg"
    
    var json: JSONDictionary {
        
        let object: JSONDictionary = ["id": id,
                                      "title": title,
                                      "thumbnail": ["path": thumb_path,
                                                    "extension": thumb_extension]]
        return object
    }
}

struct EventMock {
    
    let id: Int = 116
    let title: String = "Acts of Vengeance!"
    let thumb_path: String = "http://i.annihil.us/u/prod/marvel/i/mg/9/40/51ca10d996b8b"
    let thumb_extension: String = "jpg"
    
    var json: JSONDictionary {
        
        let object: JSONDictionary = ["id": id,
                                      "title": title,
                                      "thumbnail": ["path": thumb_path,
                                                    "extension": thumb_extension]]
        return object
    }
}

struct StoryMock {
    
    let id: Int = 486
    let title: String = "Cover #486"
    let thumb_path: String = "http://i.annihil.us/u/prod/marvel/i/mg/9/80/59b3104f67eaf"
    let thumb_extension: String = "jpg"
    
    var json: JSONDictionary {
        
        let object: JSONDictionary = ["id": id,
                                      "title": title,
                                      "thumbnail": ["path": thumb_path,
                                                    "extension": thumb_extension]]
        return object
    }
}

struct SerieMock {
    
    let id: Int = 22102
    let title: String = "A Year of Marvels (2017)"
    let thumb_path: String = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
    let thumb_extension: String = "jpg"
    
    var json: JSONDictionary {
        
        let object: JSONDictionary = ["id": id,
                                      "title": title,
                                      "thumbnail": ["path": thumb_path,
                                                    "extension": thumb_extension]]
        return object
    }
}

struct SummaryMock {
    
    let resourceURI: String = "http://gateway.marvel.com/v1/public/comics/21366"
    let name: String = "Avengers: The Initiative (2007) #14"
   
    
    var json: JSONDictionary {
        
        let object: JSONDictionary = ["resourceURI": resourceURI,
                                      "name": name]
        return object
    }
}
     