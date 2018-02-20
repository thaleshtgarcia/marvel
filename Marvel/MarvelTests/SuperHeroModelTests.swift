//
//  SuperHeroModelTests.swift
//  MarvelTests
//
//  Created by thales.garcia on 19/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import XCTest
@testable import Marvel

class SuperHeroModelTests: XCTestCase {
    
    func testSuperHeroInit() {
        
        //given
        let id = 1009610
        let name = "Spider-Man"
        let description = "Bitten by a radioactive spider, high school student Peter Parker gained the speed, strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start a career using his new abilities. Taught that with great power comes great responsibility, Spidey has vowed to use his powers to help people."
        
        let spiderManJSON = SpiderManMock().json
        
        //when
        let superHero = SuperHero(json: spiderManJSON)
    
        //then
        XCTAssertEqual(superHero.id, id)
        XCTAssertEqual(superHero.name, name)
        XCTAssertEqual(superHero.heroDescription, description)
        XCTAssert(superHero.comics?.count == 3)
        XCTAssert(superHero.events?.count == 3)
        XCTAssert(superHero.stories?.count == 3)
        XCTAssert(superHero.series?.count == 3)
    }
}
    