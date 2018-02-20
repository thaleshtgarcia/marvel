//
//  TabBarCoordinatorTests.swift
//  MarvelTests
//
//  Created by thales.garcia on 19/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import XCTest
@testable import Marvel

class TabBarCoordinatorTests: XCTestCase {
    
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        self.window = UIWindow()
    }
    
    override func tearDown() {
        window?.rootViewController = nil
        window?.resignKey()
        window = nil
        super.tearDown()
    }
    
    func testTabBarCoordinator() {
        //given
        let coordinator = TabBarCoordinator(window: window)
        
        //when
        coordinator.start()
        window.makeKeyAndVisible()
        
        //then
        XCTAssertNotNil(coordinator.tabBarController)
        XCTAssert(window.rootViewController is UITabBarController)
        XCTAssert(coordinator.tabCoordinators.count == 2)
    }
}
