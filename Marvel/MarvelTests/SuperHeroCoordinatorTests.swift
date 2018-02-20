//
//  SuperHeroCoordinatorTests.swift
//  MarvelTests
//
//  Created by thales.garcia on 19/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import XCTest

@testable import Marvel

class SuperHeroCoordinatorTests: XCTestCase {
    
    func testTabBarCoordinator() {
        //given
        
        //when
        let coordinator = SuperHeroCoordinator()
        
        //then
        XCTAssertNotNil(coordinator.rootController)
        XCTAssert(coordinator.rootController.viewControllers.count == 1)
        XCTAssert(coordinator.rootController.viewControllers.first is SuperHeroTableViewController)
        
    }
}
