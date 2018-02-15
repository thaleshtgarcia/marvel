//
//  CharactersEndpoint.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

enum CharactersEndpoint {
    case characters(offset: Int, limit: Int)
}

extension CharactersEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .characters(_ , _):
            return "/v1/public/characters"
        }
    }
    
    var task: NetworkTask {
        
        switch self {
        case let .characters(offset, limit):
            var parameters = defaultParameters
            parameters["limit"] = limit
            parameters["offset"] = offset
            return .requestParameters(parameters: parameters)
        }
    }
    
}
