//
//  StarWarsAPI+PeopleEndpointTests.swift
//  PeopleTests
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

@testable import People
import Networking
import RxSwift
import RxBlocking
import Quick
import Nimble

class SWAPIPeopleEndpointTests: QuickSpec {
  override func spec() {
    describe("extension for StarWarsAPI with PeopleEndpoint") {
      var swapi: StarWarsAPI!
      
      beforeEach {
        swapi = StarWarsAPI()
      }
      
      describe("get people from page") {
        it("gets all the people from the page") {
          let results = swapi.getPeople(from: 1)
          
          let items = try! results.toBlocking().toArray()
          
          expect(items.count).to(beGreaterThan(0))
        }
      }
      describe("get a person from id") {
        it("gets a person by id") {
          let result = swapi.getPerson(from: 1)
          
          let item = try! result.toBlocking().toArray()
          
          expect(item.count).to(equal(1))
          expect(item[0].name).toNot(beEmpty()) // Every person must have a name
        }
      }
    }
  }
}
