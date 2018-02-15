//
//  TabCoordinator.swift
//  Marvel
//
//  Created by thales.garcia on 12/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//
import UIKit

protocol TabCoordinator {
    associatedtype RootControllerType: UIViewController
    var rootController: RootControllerType { get }
    var tabBarItem: UITabBarItem { get }
}

class TabCoordinatorWrapper {
    
    static func deGenericize<T: TabCoordinator>(_ coordinator: T) -> TabCoordinatorWrapper {
        return TabCoordinatorWrapper(coordinator)
    }
    
    var rootController: UIViewController
    var tabBarItem: UITabBarItem
    
    init<T: TabCoordinator>(_ tabCoordinator: T) {
        rootController = tabCoordinator.rootController
        tabBarItem = tabCoordinator.tabBarItem
    }
    
}
