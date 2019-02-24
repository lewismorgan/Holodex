//
//  StarWarsAPI+PeopleEndpointTests.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Networking
import Nimble
@testable import People
import Quick
import RxBlocking
import RxSwift

class SWAPIPeopleEndpointTests: QuickSpec {
  override func spec() {
    describe("extension for StarWarsAPI with PeopleEndpoint") {
      var swapi: StarWarsAPI!

      beforeEach {
        swapi = StarWarsAPI()
      }

      describe("getting all people") {
        it("gets all people") {
          let results = swapi.getAll()

          let items = try! results.toBlocking().toArray()

          expect(items.count) >= 9
        }
      }
      describe("get people from page") {
        it("gets all the people from the page") {
          let results = swapi.getPeople(from: 1)

          let items = try! results.toBlocking().toArray()

          expect(items.count) > 0
        }
      }
      describe("get a person from id") {
        it("gets a person by id") {
          let result = swapi.getPerson(from: 1)

          let item = try! result.toBlocking().toArray()

          expect(item.count) == 1
          expect(item[0].name).toNot(beEmpty())
        }
      }
    }
  }
}
