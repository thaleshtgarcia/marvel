//
//  XCTestHelper.swift
//  MarvelTests
//
//  Created by thales.garcia on 20/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation
import XCTest

@testable import Marvel

extension XCTestCase {
    
    func readLocallyJSON(withFileName fileName: String) -> JSONDictionary? {
        
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                return jsonObj as? JSONDictionary
                
            } catch let error {
                print(error.localizedDescription)
                return JSONDictionary()
            }
        } else {
            print("Invalid filename/path.")
            return JSONDictionary()
        }
    }
}

