//
//  SuperHeroCoordinator.swift
//  Marvel
//
//  Created by thales.garcia on 11/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

protocol SuperHeroCoordinatorDelegate: class {
    
}

class SuperHeroCoordinator: TabCoordinator {
    
    private weak var delegate: SuperHeroCoordinatorDelegate?
    
    var rootController: UINavigationController =  UINavigationController()
    var tabBarItem: UITabBarItem = {
        let image = UIImage(named: "super-hero-icon")?.withRenderingMode(.alwaysTemplate)
        let tabBarItem =  UITabBarItem(
            title: "Heroes",
            image: image,
            selectedImage: image)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], for: .selected)
        return tabBarItem
    }()
    
    init(with delegate: SuperHeroCoordinatorDelegate) {
        self.delegate = delegate
        start()
    }
    
    private func start() {
        let storyboard = UIStoryboard(name: "SuperHero", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? SuperHeroTableViewController{
            viewController.viewModel = SuperHeroViewModel()
            rootController.setViewControllers([viewController], animated: false)
            rootController.tabBarItem = tabBarItem
        }
    }
}

