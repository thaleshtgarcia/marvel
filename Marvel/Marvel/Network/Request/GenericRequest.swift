//
//  GenericRequest.swift
//  Marvel
//
//  Created by thales.garcia on 17/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation


class GenericRequest: Requestable {
    private let network = Network()
    private var url: String = ""
    
    init(urlString: String) {
        self.url = urlString
    }
    
    func request(completion: @escaping (JSONDictionary?, ServerError?) -> Void) {
        network.request(endpoint: GenericEndpoint.fullURL(urlString: self.url)) { (response) in
            guard let data = response.json?["data"] as? JSONDictionary,
                let results = data["results"] as? [JSONDictionary],
                let collectionItemJSON = results.first else {
                    completion(nil, response.serverError)
                    return
            }
            completion(collectionItemJSON, response.serverError)
        }
    }
}
