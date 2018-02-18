//
//  FavouriteSuperHeroViewModel.swift
//  Marvel
//
//  Created by thales.garcia on 18/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class FavouriteSuperHeroViewModel: SuperHeroViewModelProtocol{
    
    private var superHeroes: [SuperHeroDTO] = []
    private var searchSuperHeroes: [SuperHeroDTO] = []
    
    var dataSource: [SuperHeroDTO] {
        return isSearching ? searchSuperHeroes : superHeroes
    }
    
    var navigationTitle: String = ""
    var favouriteIdsSet: Set<Int> = Set()
    var isSearching: Bool = false
    
    required init(title: String) {
        navigationTitle = title
        favouriteIdsSet = loadAllFavouriteIds()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshSource),
                                               name: NSNotification.Name(rawValue: Notification.Name.superHeroFavourite),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Public Methods
    func loadSuperHeroes(offset: Int = 0, completion: @escaping () -> Void) {
        if offset == 0 {
            retriveSuperHeroes()
        }
        completion()
    }
    
    func loadImage(with URL: String?, completion: @escaping ((Data?) -> Void)) {
        ImageRequest(imageURL: URL).request { (imageData) in
            completion(imageData)
        }
    }
    
    func searchSuperHero(by name: String, completion: @escaping () -> Void) {
        self.searchSuperHeroes.removeAll()
        searchSuperHeroes(by: name, completion: completion)
    }
    
    //Favourite Methods
    func favouriteSuperHero(superHero: SuperHeroDTO?, isFavourite: Bool) {

        guard let superHeroDTO = superHero else {
            return
        }
        
        if isFavourite {
            favouriteIdsSet.insert(superHeroDTO.id)
            persistFavouriteSuperHero(superHero: superHeroDTO.model())
        } else {
            favouriteIdsSet.remove(superHeroDTO.id)
            removeFavouriteSuperHero(superHero: superHeroDTO.model())
        }
    }
    
    func isFavouriteSuperHero(superHero: SuperHeroDTO) -> Bool {
        return favouriteIdsSet.contains(superHero.id)
    }
    
    @objc func refreshSource() {
        favouriteIdsSet = loadAllFavouriteIds()
        retriveSuperHeroes()
    }
    
    //MARK: Private Methods
    private func retriveSuperHeroes() {
        superHeroes.removeAll()
        if let favourites = LocalFileCache.loadAll() as? [SuperHero] {
            superHeroes = favourites.map{ SuperHeroDTO(with: $0) }
        }
    }
    
    private func searchSuperHeroes(by name: String, completion: @escaping () -> Void) {
        searchSuperHeroes = superHeroes.filter{ $0.name.contains(name) }
        completion()
    }
    
    private func persistFavouriteSuperHero(superHero: SuperHero) {
        LocalFileCache.save(object: superHero, fileName: "\(superHero.id)")
        favouriteIdsSet = loadAllFavouriteIds()
        retriveSuperHeroes()
    }
    
    private func removeFavouriteSuperHero(superHero: SuperHero) {
        LocalFileCache.remove(with:"\(superHero.id)")
        favouriteIdsSet = loadAllFavouriteIds()
        retriveSuperHeroes()
        
    }
    
    private func loadAllFavouriteIds() -> Set<Int>{
        
        if let fileNames: [String] = LocalFileCache.loadAllContentName() {
            let ids:[Int] = fileNames.map { Int($0) ?? 0}
            return Set<Int>(ids)
        }
        
        return Set<Int>()
    }
}
