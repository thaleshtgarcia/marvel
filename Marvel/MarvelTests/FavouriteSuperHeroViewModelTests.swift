//
//  FavouriteSuperHeroViewModelTests.swift
//  MarvelTests
//
//  Created by thales.garcia on 20/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import XCTest
import Foundation

@testable import Marvel

class FavouriteSuperHeroViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewModelInit() {
        //given
        let title = "Favourite Super Heroes"
        
        //when
        let viewModel = SuperHeroViewModel(title: title)
        
        //then
        XCTAssert(viewModel.navigationTitle == title)
        XCTAssertNotNil(viewModel.favouriteIdsSet)
    }
    
    func testLoadSuperHeroes() {
        //given
        let title = "Favourite Super Heroes"
        let viewModel = SuperHeroViewModel(title: title)
        let exp = expectation(description: "block-called")
        
        //when
        viewModel.loadSuperHeroes {
            XCTAssert(viewModel.dataSource.count > 0)
            exp.fulfill()
        }
        
        //then
        let waiter = XCTWaiter.wait(for: [exp], timeout: 5)
        XCTAssert(waiter == .completed)
    }
    
    func testSearchSuperHeroByName() {
        //given
        let title = "Favourite Super Heroes"
        let searchText = "Spider"
        let viewModel = SuperHeroViewModel(title: title)
        viewModel.isSearching = true
        let exp = expectation(description: "block-called")
        
        //when
        viewModel.searchSuperHero(by: searchText) {
            XCTAssert(viewModel.dataSource.count > 0)
            exp.fulfill()
        }
        
        //then
        let waiter = XCTWaiter.wait(for: [exp], timeout: 5)
        XCTAssert(waiter == .completed)
    }
    
    //Private methods
    fileprivate func save(object: SuperHero, fileName: String) {
        
        guard let fileUrl = documentsDirectoryUrl(with: fileName) else { return }
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            try data.write(to: fileUrl, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    fileprivate func documentsDirectoryUrl(with name: String? = nil) -> URL? {
        guard let documentDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let customDirectoryURL = documentDirectoryURL.appendingPathComponent("heroes")
        
        if FileManager.default.fileExists(atPath: customDirectoryURL.path) == false {
            do {
                try FileManager.default.createDirectory(at: customDirectoryURL, withIntermediateDirectories: false, attributes: nil)
            } catch { }
        }
        
        if let fileName = name {
            return customDirectoryURL.appendingPathComponent("\(fileName).json")
        }
        
        return customDirectoryURL
    }
}

