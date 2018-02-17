//
//  LoadImageProtocol.swift
//  Marvel
//
//  Created by thales.garcia on 16/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

protocol LoadImageDelegate: class {
    func load(imageURL: String?, completion: @escaping (UIImage?) -> Void)
}
