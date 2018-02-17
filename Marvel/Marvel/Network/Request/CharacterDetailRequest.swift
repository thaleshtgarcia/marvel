//
//  CharacterDetailRequest.swift
//  Marvel
//
//  Created by thales.garcia on supe15/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class CharacterDetailRequest: Requestable {
    private let network = Network()
    private var characterId: Int = 0
    
    init(characterId: Int = 0) {
        self.characterId = characterId
    }
    
    func request(completion: @escaping (SuperHero?, ServerError?) -> Void) {
        network.request(endpoint: CharactersEndpoint.character(id: characterId)) { (response) in
            guard let data = response.json?["data"] as? JSONDictionary,
                let results = data["results"] as? [JSONDictionary],
                let characterJSON = results.first else {
                    return
            }
            
            let superHero = SuperHero(json: characterJSON)
            
            completion(superHero, response.serverError)
        }
    }
}
