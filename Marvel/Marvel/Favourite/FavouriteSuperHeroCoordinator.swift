//
//  FavouriteSuperHeroCoordinator.swift
//  Marvel
//
//  Created by thales.garcia on 15/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import UIKit

class FavouriteSuperHeroCoordinator: TabCoordinator {
    
    var rootController: UINavigationController =  UINavigationController()
    var tabBarItem: UITabBarItem = {
        let tabBarItem =  UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return tabBarItem
    }()
    
    init() {
        start()
    }
    
    private func start() {
        showSuperHeroTableViewController()
    }
    
    private func showSuperHeroTableViewController() {
        let storyboard = UIStoryboard(name: "SuperHero", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? SuperHeroTableViewController {
            
            let viewModel = FavouriteSuperHeroViewModel(title: "Favourite Super Heroes")
            viewController.setupViewController(delegate: self, viewModel: viewModel)
            
            rootController.setViewControllers([viewController], animated: true)
            rootController.tabBarItem = tabBarItem
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

extension FavouriteSuperHeroCoordinator: SuperHeroListDelegate {
    func select(superHero: SuperHeroDTO) {
        showSuperHeroDetailTableViewController(with: superHero)
    }
}
