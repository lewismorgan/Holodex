//
//  StarWarsAPITests.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

@testable import Networking
import Nimble
import ObjectMapper
import Quick
import RxBlocking
import RxSwift
import RxTest

// ONLY TEST PUBLIC METHODS !

class StarWarsAPITests: QuickSpec {
  override func spec() {
    describe("a Star Wars API") {
      // Setup
      var swapi: StarWarsAPI!
      var endpoint: String = ""

      beforeEach {
        swapi = StarWarsAPI()
        endpoint = "planets"
      }

      // Method Tests
      describe("building a request") {
        it("creates a request to the API") {
          let result = try! swapi.buildRequest(endpoint: "\(endpoint)/1/", type: NamedResult.self).toBlocking().first()!
          expect(result.name) == "Tatooine"
        }
      }
      describe("building a streaming page request") {
        it("builds a streaming paged request that completes") {
          let request = swapi.buildStreamingPageRequest(endpoint: endpoint, page: 1, type: NamedResult.self).share()

          // the last item should not have another page
          let last = try! request.asObservable().toBlocking().last()

          expect(last?.1) == false
        }
      }
      describe("building a page request") {
        it("creates a request for a single page detailing the next page") {
          let firstPage = 1
          let secondPage = 2
          let request = swapi.buildPageRequest(endpoint: endpoint, page: firstPage, type: NamedResult.self)

          let items = try! request.toBlocking().toArray()

          expect(items.count) == 1
          expect(items[0].nextPage) == secondPage
        }
      }
    }
  }
}

class NamedResult: Mappable {
  public var name: String! = ""

  required init?(map: Map) {
  }

  public func mapping(map: Map) {
    name <- map["name"]
  }
}
