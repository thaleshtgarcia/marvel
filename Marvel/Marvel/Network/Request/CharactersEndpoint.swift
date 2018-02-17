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
    case character(id: Int)
    case searchCharacter(byName: String)
}

extension CharactersEndpoint: Endpoint {
    
    var path: String {
        
        let defaultPath = "/v1/public/characters"
        
        switch self {
        case .characters(_ , _):
            return defaultPath
        case let .character(id):
            return defaultPath + "/\(id)"
        case .searchCharacter(_):
            return defaultPath
        }
    }
    
    var task: NetworkTask {
        
        var parameters = defaultParameters
        
        switch self {
        case let .characters(offset, limit):
            parameters["limit"] = limit
            parameters["offset"] = offset
            return .requestParameters(parameters: parameters)
        case .character(_):
            return .requestParameters(parameters: parameters)
        case let .searchCharacter(name):
            parameters["nameStartsWith"] = name
            return .requestParameters(parameters: parameters)
        }
    }
    
}
