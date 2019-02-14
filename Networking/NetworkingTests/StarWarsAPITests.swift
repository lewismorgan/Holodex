//
//  StarWarsAPITests.swift
//  NetworkingTests
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

@testable import Networking
import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking
import ObjectMapper

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
        let nPages = 3
        it("builds a streaming paged request with a trigger for \(nPages) pages") {
          let trigger = PublishSubject<Void>()
          let request = swapi.buildStreamingPageRequest(endpoint: endpoint, page: 1,
                                               loadNext: trigger.asObservable().startWith(()), type: NamedResult.self).take(nPages)
          
          let items = try! request.toBlocking().toArray()
          
          // There should be nPages of arrays emitted by the stream
          expect(items.count) == nPages
        }
      }
      describe("building a page request") {
        it("creates a request for a single page detailing the next page") {
          let request = swapi.buildPageRequest(endpoint: endpoint, page: 1, type: NamedResult.self)
          
          let items = try! request.toBlocking().toArray()
          
          expect(items.count) == 1
          expect(items[0].nextPage) == 2
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
