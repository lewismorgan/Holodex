//
//  StarWarsAPITests.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//
//
@testable import HoloDex
import Nimble
import Quick
import RxTest

// ONLY TEST PUBLIC METHODS !

class StarWarsAPITests: QuickSpec {
  struct BadDecode: Decodable {
    let name: String
  }
  struct EndpointList: Decodable, Equatable {
    let people: String
    let planets: String
    let films: String
    let species: String
    let vehicles: String
    let starships: String
  }

  struct EndpointItem: Decodable, Equatable {
    let detail: String
  }

  override func spec() {
    describe("a Star Wars API") {
      // Setup
      var swapi: StarWarsAPI!
      var scheduler: TestScheduler!

      beforeEach {
        swapi = StarWarsAPI()
        scheduler = TestScheduler(initialClock: 0)
      }

      // Method Tests
      describe("a request") {
        it("emits the decoded response") {
          let request = scheduler.start { swapi.createRequest(endpoint: "", type: EndpointList.self) }
          let baseUrl = "https://swapi.co/api/"
          let expectedResult = Recorded.events([
            .next(0, EndpointList(people: baseUrl + "people", planets: baseUrl + "planets", films: baseUrl + "films", species: baseUrl + "species", vehicles: baseUrl + "vehicles", starships: baseUrl + "vehicles")),
            .completed(0)
          ])

          expect(request.events) == expectedResult
        }
        context("when the request is bad") {
          it("emits null mapping") {
            let request = scheduler.start { swapi.createRequest(endpoint: "", type: BadDecode.self) }
            expect(request.events.count) == 2
            // expect request.events to contain NullMapping error
          }
        }
      }
      describe("a page request") {
        it("emits all the pages") {

        }
      }
    }
  }
}
