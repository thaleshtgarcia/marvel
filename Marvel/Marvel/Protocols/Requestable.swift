//
//  Requestable.swift
//  Marvel
//
//  Created by thales.garcia on 13/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

protocol Requestable: class {
    associatedtype DataType
    func request(completion: @escaping (_ result: DataType?, _ error: ServerError?) -> Void)
}
