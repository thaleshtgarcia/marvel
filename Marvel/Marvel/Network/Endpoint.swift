//
//  Endpoint.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    //The server base URL. i.e:"https://marvel.com/"
    var baseURL: URL { get }
    
    //The enpoint path. i.e: "/v1/public/characters"
    var path: String { get }
    
    //How the parameters should be manipulated
    var task: NetworkTask { get }
    
    //Enpoint method
    var method: RequestHTTPMethod { get }
    
    //Enpoint headers
    var headers: [String: String]? { get }
}

public enum NetworkTask {
    
    // A request with no additional data.
    case requestPlain
    
    // A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any])
    
    // A requests body set with encoded parameters combined with url parameters.
    case requestCompositeBodyData(data: Data, urlParameters: [String: Any])
}

extension Endpoint {
    
    var defaultParameters: [String: Any] {
        let ts = "\(Int(Date().timeIntervalSince1970))"
        let parameters = ["ts" : ts,
                          "apikey": publicKey,
                          "hash" : hashValue(ts: ts)]
        return parameters
    }
    
    var publicKey: String {
        return "226e33690f24a60d092d2618dd90ae6d"
    }
    
    var privateKey: String {
        return "4ca449da0d5d6cf32985f172a503074858cd05b1"
    }

    var baseURL: URL {
        guard let url = URL(string: "https://gateway.marvel.com:443/") else {
            return URL(fileURLWithPath: "")
        }
        return url
    }
    
    var path: String {
        return ""
    }
    
    var task: NetworkTask {
        return .requestParameters(parameters: defaultParameters)
    }
    
    var method: RequestHTTPMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    private func hashValue(ts: String) -> String {
        let hash = ts+privateKey+publicKey
         return hash.MD5()
    }
}
