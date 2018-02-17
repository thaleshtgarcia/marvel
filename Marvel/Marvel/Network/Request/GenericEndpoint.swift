//
//  GenericEndpoint.swift
//  Marvel
//
//  Created by thales.garcia on 17/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation
enum GenericEndpoint {
    case fullURL(urlString: String)
}

extension GenericEndpoint: Endpoint {
    
    var baseURL: URL {
        switch self {
        case let .fullURL(urlString):
            guard let url = URL(string: urlString) else {
                return URL(fileURLWithPath: "")
            }
            return url
        }
    }
    
    var path: String {
        return ""
    }
    var task: NetworkTask {
        return .requestParameters(parameters: defaultParameters)
    }
}
