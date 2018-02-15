//
//  CharactersRequest.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class CharactersRequest: Requestable {
    private let network = Network()
    private var offset: Int = 0
    private var limit: Int = 20
    
    init(offset: Int = 0) {
        self.offset = offset
    }
    
    func request(completion: @escaping ([SuperHero]?, ServerError?) -> Void) {
        network.request(endpoint: CharactersEndpoint.characters(offset: offset, limit: limit)) { (response) in
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
