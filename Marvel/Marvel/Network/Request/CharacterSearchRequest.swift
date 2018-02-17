//
//  CharacterSearchRequest.swift
//  Marvel
//
//  Created by thales.garcia on 17/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class CharacterSearchRequest: Requestable {
    private let network = Network()
    private var name: String = ""
    
    init(name: String) {
        self.name = name
    }
    
    func request(completion: @escaping ([SuperHero]?, ServerError?) -> Void) {
        network.request(endpoint: CharactersEndpoint.searchCharacter(byName: self.name)) { (response) in
            guard let data = response.json?["data"] as? JSONDictionary,
                let results = data["results"] as? [JSONDictionary]  else {
                    return
            }
            
            var object: [SuperHero] = []
            for characterJSON in results {
                let superHero = SuperHero(json: characterJSON)
                object.append(superHero)
            }
            
            completion(object, response.serverError)
        }
    }
}
