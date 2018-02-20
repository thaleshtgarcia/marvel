//
//  SpiderManMock.swift
//  MarvelTests
//
//  Created by thales.garcia on 19/02/18.
//  Copyright © 2018 thales.garcia. All rights reserved.
//

@testable import Marvel

struct SpiderManMock {
    
    var json: JSONDictionary {
        
        let comics: [JSONDictionary] = [["name":"Spider-Man: 101 Ways to End the Clone Saga (1997) #1",
                                         "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\comics\\62304"],
                                        ["name":"A Year of Marvels (Trade Paperback)",
                                         "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\comics\\60151"],
                                        ["name":"A Year of Marvels: April Infinite Comic (2016) #1",
                                         "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\comics\\57926"]]
        
        
        let events: [JSONDictionary] = [["name":"Acts of Vengeance!",
                                         "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\events\\116"],
                                        ["name":"Age of Ultron",
                                         "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\events\\314"],
                                        [ "name":"Atlantis Attacks",
                                          "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\events\\233"]]
        
        let stories: [JSONDictionary] = [["name":"Interior #483",
                                          "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\stories\\483"],
                                         ["name":"Cover #486",
                                          "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\stories\\486"],
                                         ["name":"Interior #487",
                                          "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\stories\\487"]]
        
        let series: [JSONDictionary] = [["name":"A Year of Marvels (2017)",
                                         "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\series\\22102"],
                                        ["name":"A Year of Marvels: April Infinite Comic (2016 - Present)",
                                         "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\series\\21110"],
                                        ["name":"A+X (2012 - Present)",
                                         "resourceURI":"http:\\\\gateway.marvel.com\\v1\\public\\series\\16450"]]

        let json: JSONDictionary = ["id" : 1009610,
                                    "name" : "Spider-Man",
                                    "description" : "Bitten by a radioactive spider, high school student Peter Parker gained the speed, strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start a career using his new abilities. Taught that with great power comes great responsibility, Spidey has vowed to use his powers to help people.",
                                    "thumbnail" : ["path":"http:\\i.annihil.usu\\prod\\marvel\\i\\mg\\3\\50\\526548a343e4b",
                                                   "extension":"jpg"],
                                    "comics" : ["items": comics],
                                    "events" : ["items": events],
                                    "stories" : ["items": stories],
                                    "series" : ["items": series]]
        
        return json
    }
}
