//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by thales.garcia on 10/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import XCTest

class MarvelUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        removeAllFiles()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        removeAllFiles()
        super.tearDown()
    }
    
    func testLoadSuperHeroList() {
        app.launch()
    
        let firstCell = app.tables.cells.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == true")
        
        expectation(for: exists, evaluatedWith: firstCell, handler: nil)
        
        //Open details of first Hero
        app.tables.cells.element(boundBy: 0).tap()
        
        waitForExpectations(timeout: 10, handler: nil)
        
        //Favourite the hero
        app.tables.cells["SuperHeroDetailTableViewCell"].buttons.firstMatch.tap()
        
        //Go back
        app.navigationBars.buttons.firstMatch.tap()
        
        //Tap the favourite tab
        app.tabBars.buttons["Favorites"].tap()
        
        //Open details
        app.tables.cells.element(boundBy: 0).tap()
    }
    
    //Private methods
    fileprivate func removeAllFiles() {
        guard let cacheDirectoryUrl = documentsDirectoryUrl() else { return }
        if FileManager.default.fileExists(atPath: cacheDirectoryUrl.relativePath) {
            _ = try? FileManager.default.removeItem(atPath: cacheDirectoryUrl.relativePath)
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

