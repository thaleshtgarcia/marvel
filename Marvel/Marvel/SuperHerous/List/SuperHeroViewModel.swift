//
//  SuperHeroViewModel.swift
//  Marvel
//
//  Created by thales.garcia on 12/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

struct SuperHeroDTO {
    var id: Int
    var thumb: String?
    var name: String
    var heroDescription: String
    var comics: [SummaryItem]?
    var events: [SummaryItem]?
    var stories: [SummaryItem]?
    var series: [SummaryItem]?
    
    init(with superHero: SuperHero) {
        id = superHero.id
        name = superHero.name
        heroDescription = superHero.heroDescription
        thumb = superHero.thumb?.fullPath
        comics = superHero.comics
        events = superHero.events
        stories = superHero.stories
        series = superHero.series
    }
}

class SuperHeroViewModel {
    
    var superHeroes: [SuperHeroDTO] = []
    
    //MARK: Public Methods
    func loadSuperHeroes(completion: @escaping () -> Void) {
        requestSuperHeroes(offset: 0, completion: completion)
    }
    
    func loadNextPage(completion: @escaping () -> Void) {
        requestSuperHeroes(offset: superHeroes.count, completion: completion)
    }
    
    func loadImage(with URL: String?, completion: @escaping ((Data?) -> Void)) {
        ImageRequest(imageURL: URL).request { (imageData) in
            completion(imageData)
        }
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
}
