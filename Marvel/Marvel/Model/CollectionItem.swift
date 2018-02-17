//
//  CollectionItem.swift
//  Marvel
//
//  Created by thales.garcia on 16/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

protocol CollectionItem {
    var id: Int { get set }
    var title: String  { get set }
    var thumb: Image? { get set }
}
