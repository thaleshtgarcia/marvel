//
//  TabBarCoordinator.swift
//  Marvel
//
//  Created by thales.garcia on 11/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    unowned let window: UIWindow
    var tabBarController: UITabBarController
    var tabCoordinators: [TabCoordinatorWrapper] = []
    
    var superHeroCoordinator: SuperHeroCoordinator {
        return SuperHeroCoordinator(with: self)
    }
    
    // MARK: - Initialization methods
    init(window: UIWindow) {
        self.window = window
        self.tabBarController = UITabBarController(nibName: nil, bundle: nil)
    }
    
    // MARK: - Public methods
    func start() {
        self.window.rootViewController = tabBarController
        setupTabs()
    }
    
    // MARK: - Private methods
    private func setupTabs() {
        tabCoordinators.append(TabCoordinatorWrapper.deGenericize(superHeroCoordinator))
        tabBarController.viewControllers = tabCoordinators.map { $0.rootController }
    }
}

extension TabBarCoordinator: SuperHeroCoordinatorDelegate {
    
}
