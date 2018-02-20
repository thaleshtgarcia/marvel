//
//  ModelTests.swift
//  MarvelTests
//
//  Created by thales.garcia on 19/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

import XCTest
@testable import Marvel

class ModelsTests: XCTestCase {
    
    func testComicInitSuccess() {
        
        //given
        let objectMock = ComicMock()
        
        //when
        let objectModel = Comic(json: objectMock.json)
        
        //then
        XCTAssertEqual(objectModel.id, objectMock.id)
        XCTAssertEqual(objectModel.title, objectMock.title)
        XCTAssertNotNil(objectModel.thumb)
        XCTAssertEqual(objectModel.thumb?.path, objectMock.thumb_path)
        XCTAssertEqual(objectModel.thumb?.imageExtension, objectMock.thumb_extension)
    }
    
    func testComicInitWrongJSON() {
        //given
        let objectMock: JSONDictionary = ["test":"failed"]
        
        //when
        let objectModel = Comic(json: objectMock)
        
        //then
        XCTAssertEqual(objectModel.id, 0)
        XCTAssertEqual(objectModel.title, "")
        XCTAssertNil(objectModel.thumb)
    }
    
    func testEventInitSuccess() {
        
        //given
        let objectMock = EventMock()
        
        //when
        let objectModel = Event(json: objectMock.json)
        
        //then
        XCTAssertEqual(objectModel.id, objectMock.id)
        XCTAssertEqual(objectModel.title, objectMock.title)
        XCTAssertNotNil(objectModel.thumb)
        XCTAssertEqual(objectModel.thumb?.path, objectMock.thumb_path)
        XCTAssertEqual(objectModel.thumb?.imageExtension, objectMock.thumb_extension)
    }
    
    func testEventInitWrongJSON() {
        //given
        let objectMock: JSONDictionary = ["test":"failed"]
        
        //when
        let objectModel = Event(json: objectMock)
        
        //then
        XCTAssertEqual(objectModel.id, 0)
        XCTAssertEqual(objectModel.title, "")
        XCTAssertNil(objectModel.thumb)
    }
    
    func testStoryInitSuccess() {
        
        //given
        let objectMock = StoryMock()
        
        //when
        let objectModel = Story(json: objectMock.json)
        
        //then
        XCTAssertEqual(objectModel.id, objectMock.id)
        XCTAssertEqual(objectModel.title, objectMock.title)
        XCTAssertNotNil(objectModel.thumb)
        XCTAssertEqual(objectModel.thumb?.path, objectMock.thumb_path)
        XCTAssertEqual(objectModel.thumb?.imageExtension, objectMock.thumb_extension)
        
    }
    
    func testStoryInitWrongJSON() {
        //given
        let objectMock: JSONDictionary = ["test":"failed"]
        
        //when
        let objectModel = Story(json: objectMock)
        
        //then
        XCTAssertEqual(objectModel.id, 0)
        XCTAssertEqual(objectModel.title, "")
        XCTAssertNil(objectModel.thumb)
    }
    
    func testSerieInitSuccess() {
        
        //given
        let objectMock = SerieMock()
        
        //when
        let objectModel = Serie(json: objectMock.json)
        
        //then
        XCTAssertEqual(objectModel.id, objectMock.id)
        XCTAssertEqual(objectModel.title, objectMock.title)
        XCTAssertNotNil(objectModel.thumb)
        XCTAssertEqual(objectModel.thumb?.path, objectMock.thumb_path)
        XCTAssertEqual(objectModel.thumb?.imageExtension, objectMock.thumb_extension)
    }
    
    func testSerieInitWrongJSON() {
        //given
        let objectMock: JSONDictionary = ["test":"failed"]
        
        //when
        let objectModel = Serie(json: objectMock)
        
        //then
        XCTAssertEqual(objectModel.id, 0)
        XCTAssertEqual(objectModel.title, "")
        XCTAssertNil(objectModel.thumb)
    }
    
    func testSummaryInitSuccess() {
        
        //given
        let objectMock = SerieMock()
        
        //when
        let objectModel = Serie(json: objectMock.json)
        
        //then
        XCTAssertEqual(objectModel.id, objectMock.id)
        XCTAssertEqual(objectModel.title, objectMock.title)
        XCTAssertNotNil(objectModel.thumb)
        XCTAssertEqual(objectModel.thumb?.path, objectMock.thumb_path)
        XCTAssertEqual(objectModel.thumb?.imageExtension, objectMock.thumb_extension)
    }
    
    func testSummaryInitWrongJSON() {
        //given
        let objectMock = SummaryMock()
        
        //when
        let objectModel = SummaryItem(json: objectMock.json)
        
        //then
        XCTAssertEqual(objectModel.resourceURI, objectMock.resourceURI)
        XCTAssertEqual(objectModel.name, objectMock.name)
    }
}

