//
//  SuperHeroCoordinator.swift
//  Marvel
//
//  Created by thales.garcia on 11/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

class SuperHeroCoordinator: TabCoordinator {
    
    var rootController: UINavigationController =  UINavigationController()
    var tabBarItem: UITabBarItem = {
        let image = UIImage(named: "super-hero-icon")?.withRenderingMode(.alwaysTemplate)
        let tabBarItem =  UITabBarItem(
            title: "Heroes",
            image: image,
            selectedImage: image)

        return tabBarItem
    }()
    
    init() {
        self.start()
    }
    
    func start() {
        showSuperHeroTableViewController()
    }
    
    private func showSuperHeroTableViewController() {
        let storyboard = UIStoryboard(name: "SuperHero", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? SuperHeroTableViewController {
            
            rootController.setViewControllers([viewController], animated: true)
            rootController.tabBarItem = tabBarItem
            
            let viewModel = SuperHeroViewModel(title: "Super Heroes")
            viewController.setupViewController(delegate: self, viewModel: viewModel)
        }
    }
    
    private func showSuperHeroDetailTableViewController(with superHero: SuperHeroDTO) {
        let storyboard = UIStoryboard(name: "SuperHeroDetail", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? SuperHeroDetailTableViewController{
            viewController.viewModel = SuperHeroDetailViewModel(with: superHero)
            rootController.show(viewController, sender: nil)
        }
    }
}

extension SuperHeroCoordinator: SuperHeroListDelegate {
    func select(superHero: SuperHeroDTO) {
        showSuperHeroDetailTableViewController(with: superHero)
    }
}
