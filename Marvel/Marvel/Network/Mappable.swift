//
//  Mappable.swift
//  Marvel
//
//  Created by thales.garcia on 14/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

protocol Mappable: Codable { }

precedencegroup ExponentiativePrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator <--> :ExponentiativePrecedence

func <--> <T: Mappable>(jsonData: Data?, type: T.Type) -> T? {
    
    guard let data = jsonData else {
        return nil
    }
    
    return try? JSONDecoder().decode(T.self, from: data)
}

func <--> <T: Mappable>(jsonData: Data?, type: [T.Type]) -> [T]? {
    
    guard let data = jsonData else {
        return nil
    }
    return try? JSONDecoder().decode([T].self, from: data)
}
