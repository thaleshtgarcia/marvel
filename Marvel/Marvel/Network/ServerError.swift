//
//  ServerError.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

enum ServerError {
    
    case error(Int?, String?)
    case success
    
    init(json: JSONDictionary?, statusCode: Int) {
        let errorMessage = json?["status"] as? String
//        let errorCode = json?["code"] as? Int
        
        switch statusCode {
        case 200..<300:
            self = .success
        default:
            self = .error(statusCode, errorMessage)
        }
    }
}
