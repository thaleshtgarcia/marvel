//
//  AppAppearance.swift
//  Marvel
//
//  Created by thales.garcia on 15/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

class AppAppearance {
    class func setupTabBarAppearance() {
        UITabBar.appearance().tintColor = UIColor.red
        UITabBar.appearance().backgroundColor = UIColor.black
        UITabBar.appearance().isOpaque = true
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], for: .selected)
    }
    
    class func setupNavigationAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.red
        
    }
}
