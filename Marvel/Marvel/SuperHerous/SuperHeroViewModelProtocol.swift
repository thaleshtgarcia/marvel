//
//  SuperHeroViewModelProtocol.swift
//  Marvel
//
//  Created by thales.garcia on 18/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

protocol SuperHeroViewModelProtocol {
    
    var dataSource: [SuperHeroDTO] { get }
    
    var navigationTitle: String { get set }
    var favouriteIdsSet: Set<Int> { get set }
    var isSearching: Bool { get set }
    
    init(title: String)

    func loadSuperHeroes(offset: Int, completion: @escaping () -> Void)
    func loadImage(with URL: String?, completion: @escaping ((Data?) -> Void))
    func searchSuperHero(by name: String, completion: @escaping () -> Void)
    func favouriteSuperHero(superHero: SuperHeroDTO?, isFavourite: Bool)
    func isFavouriteSuperHero(superHero: SuperHeroDTO) -> Bool
}

struct SuperHeroDTO {
    
    private var superHero: SuperHero
    
    var id: Int {
        return superHero.id
    }
    var thumb: String? {
        return superHero.thumb?.fullPath
    }
    var name: String {
        return superHero.name
    }
    var heroDescription: String {
        return superHero.heroDescription
    }
    var comics: [SummaryItem]? {
        return superHero.comics
    }
    var events: [SummaryItem]? {
        return superHero.events
    }
    var stories: [SummaryItem]? {
        return superHero.stories
    }
    var series: [SummaryItem]? {
        return superHero.series
    }
    
    var isFavourite: Bool
    
    init(with superHero: SuperHero) {
        self.superHero = superHero
        isFavourite = false
    }
    
    func model() -> SuperHero {
        return superHero
    }
}
