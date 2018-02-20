//
//  SuperHeroViewModelTests.swift
//  MarvelTests
//
//  Created by thales.garcia on 19/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import XCTest

@testable import Marvel

class SuperHeroViewModelTests: XCTestCase {
    
    func testViewModelInit() {
        //given
        let title = "Super Hero"
        
        //when
        let viewModel = SuperHeroViewModel(title: title)
        
        //then
        XCTAssert(viewModel.navigationTitle == title)
        XCTAssertNotNil(viewModel.favouriteIdsSet)
    }
    
    func testLoadSuperHeroes() {
        //given
        let title = "Super Hero"
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
        let title = "Super Hero"
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
}

