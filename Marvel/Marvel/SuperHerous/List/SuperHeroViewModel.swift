//
//  SuperHeroViewModel.swift
//  Marvel
//
//  Created by thales.garcia on 12/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

class SuperHeroViewModel: SuperHeroViewModelProtocol{
    
    var superHeroes: [SuperHeroDTO] = []
    var searchSuperHeroes: [SuperHeroDTO] = []
    
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
            superHeroes.removeAll()
        }
        requestSuperHeroes(offset: offset, completion: completion)
    }
        
    func loadImage(with URL: String?, completion: @escaping ((Data?) -> Void)) {
        ImageRequest(imageURL: URL).request { (imageData) in
            completion(imageData)
        }
    }
    
    func searchSuperHero(by name: String, completion: @escaping () -> Void) {
        self.searchSuperHeroes.removeAll()
        requestSearchSuperHeroes(by: name, completion: completion)
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
    }
    
    //MARK: Private Methods
    private func requestSuperHeroes(offset: Int, completion: @escaping () -> Void) {
        CharactersRequest(offset: offset).request { [weak self] ( result , _) in
            guard let superHeroesModel = result else {
                completion()
                return
            }
            
            var dtos: [SuperHeroDTO] = []
            for each in superHeroesModel {
                let dto = SuperHeroDTO(with: each)
                dtos.append(dto)
            }
            
            self?.superHeroes.append(contentsOf: dtos)
            completion()
        }
    }
    
    private func requestSearchSuperHeroes(by name: String, completion: @escaping () -> Void) {
        CharacterSearchRequest(name: name).request { [weak self] ( result , _) in
            guard let superHeroesModel = result else {
                completion()
                return
            }
            
            var dtos: [SuperHeroDTO] = []
            for each in superHeroesModel {
                let dto = SuperHeroDTO(with: each)
                dtos.append(dto)
            }
            
            self?.searchSuperHeroes.append(contentsOf: dtos)
            completion()
        }
    }
    
    private func persistFavouriteSuperHero(superHero: SuperHero) {
        LocalFileCache.save(object: superHero, fileName: "\(superHero.id)")
        favouriteIdsSet = loadAllFavouriteIds()
    }
    
    private func removeFavouriteSuperHero(superHero: SuperHero) {
        LocalFileCache.remove(with:"\(superHero.id)")
        favouriteIdsSet = loadAllFavouriteIds()
    }
    
    private func loadAllFavouriteIds() -> Set<Int>{
        
        if let fileNames: [String] = LocalFileCache.loadAllContentName() {
            let ids:[Int] = fileNames.map { Int($0) ?? 0}
            return Set<Int>(ids)
        }
        
        return Set<Int>()
    }
}
