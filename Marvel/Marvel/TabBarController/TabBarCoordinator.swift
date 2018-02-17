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
    
    lazy var superHeroCoordinator: SuperHeroCoordinator = {
        return SuperHeroCoordinator(with: self)
    }()
    
    lazy var favouSuperHeroCoordinator: FavouriteSuperHeroCoordinator = {
        return FavouriteSuperHeroCoordinator()
    }()
    
    var currentCoordinator: TabCoordinatorWrapper?
    
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
        tabCoordinators.append(TabCoordinatorWrapper.deGenericize(favouSuperHeroCoordinator))
        
        tabBarController.viewControllers = tabCoordinators.map { $0.rootController }
    }
}

extension TabBarCoordinator: SuperHeroCoordinatorDelegate {
    
}
