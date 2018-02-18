//
//  SuperHeroDetailViewModel.swift
//  Marvel
//
//  Created by thales.garcia on 15/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import Foundation

struct SuperHeroDetailDTO {
    var details: SuperHeroDTO?
    var comics: [Comic] = []
    var events: [Event] = []
    var stories: [Story] = []
    var series: [Serie] = []
    
    mutating func appendComic(item: Comic) {
        comics.append(item)
    }
    
    mutating func appendEvent(item: Event) {
        events.append(item)
    }
    
    mutating func appendStory(item: Story) {
        stories.append(item)
    }
    
    mutating func appendSerie(item: Serie) {
        series.append(item)
    }
}

enum SuperHeroDetailCellType: String {
    case superHeroDetail = ""
    case comics = "Comics"
    case events = "Events"
    case stories = "Stories"
    case series = "Series"
}

class SuperHeroDetailViewModel {
    
    var superHero: SuperHeroDetailDTO = SuperHeroDetailDTO()
    var cells: [SuperHeroDetailCellType] = [.superHeroDetail, .comics, .events, .stories, .series]
    
    var favouriteIdsSet: Set<Int> = Set()
    
    var numberOfSections: Int {
        return cells.count
    }
    
    init(with superHero: SuperHeroDTO) {
        self.superHero.details = superHero
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
    func loadComicsCollection(completion: @escaping () -> Void) {
        guard let collectionItems = superHero.details?.comics else {
            completion()
            return
        }
        requestCollection(collectionItems: collectionItems) { [weak self] (itemsJSON) in
            for item in itemsJSON {
                let comic = Comic(json: item)
                self?.superHero.appendComic(item: comic)
            }
            completion()
        }
    }
    
    func loadEventsCollection(completion: @escaping () -> Void) {
        guard let collectionItems = superHero.details?.events else {
            completion()
            return
        }
        requestCollection(collectionItems: collectionItems) { [weak self] (itemsJSON) in
            for item in itemsJSON {
                let event = Event(json: item)
                self?.superHero.appendEvent(item: event)
            }
            completion()
        }
    }
    
    func loadStoriesCollection(completion: @escaping () -> Void) {
        guard let collectionItems = superHero.details?.stories else {
            completion()
            return
        }
        requestCollection(collectionItems: collectionItems) { [weak self] (itemsJSON) in
            for item in itemsJSON {
                let stories = Story(json: item)
                self?.superHero.appendStory(item: stories)
            }
            completion()
        }
    }
    
    func loadSeriesCollection(completion: @escaping () -> Void) {
        guard let collectionItems = superHero.details?.comics else {
            completion()
            return
        }
        requestCollection(collectionItems: collectionItems) { [weak self] (itemsJSON) in
            for item in itemsJSON {
                let series = Serie(json: item)
                self?.superHero.appendSerie(item: series)
            }
            completion()
        }
    }
    
    func collection(forType type:SuperHeroDetailCellType ) -> [CollectionItem]? {
        switch type {
        case .comics:
            return superHero.comics
        case .events:
            return superHero.events
        case .stories:
            return superHero.stories
        case .series:
            return superHero.series
        default:
            return nil
        }
    }
    
    func numberOfRows( type:SuperHeroDetailCellType) -> Int {
        switch type {
        case .comics:
            return superHero.comics.count
        case .events:
            return superHero.events.count
        case .stories:
            return superHero.stories.count
        case .series:
            return superHero.series.count
        default:
            return 1
        }
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
    
    func isFavouriteSuperHero(superHero: SuperHeroDTO?) -> Bool {
        guard let superHeroId = superHero?.id else {
            return false
        }
        return favouriteIdsSet.contains(superHeroId)
    }
    
    @objc func refreshSource() {
        favouriteIdsSet = loadAllFavouriteIds()
    }
    
    //MARK: Private Methods
    private func requestCollection(collectionItems: [SummaryItem], completion: @escaping ([JSONDictionary]) -> Void) {
        
        let first3CollectionItems = collectionItems.enumerated().flatMap{ $0.offset < 3 ? $0.element : nil }
        var counter: Int = 0
    
        for item in first3CollectionItems {
            counter += 1
            GenericRequest(urlString: item.resourceURI).request(completion: { (json, error) in
                
                var itemDetails: [JSONDictionary] = []
                
                guard let itemJSON = json else {
                    completion(itemDetails)
                    return
                }
                
                itemDetails.append(itemJSON)
                
                if counter == first3CollectionItems.count {
                    completion(itemDetails)
                }
            })
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
