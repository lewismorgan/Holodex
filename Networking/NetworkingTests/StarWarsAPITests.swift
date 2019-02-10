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
      var swapi: StarWarsAPI!

      beforeEach {
        swapi = StarWarsAPI()
      }

      describe("building a request") {
        it("creates a request to the API") {
          let result = try! swapi.buildRequest(endpoint: "planets", type: NamedResult.self).toBlocking().first()!
          expect(result.results.count) != 0
        }
      }
      
      describe("building a next page request") {
        var baseRequest: StarWarsAPIResponse<NamedResult>!
        beforeEach {
          baseRequest = StarWarsAPIResponse<NamedResult>()
          baseRequest.next = "https://swapi.co/api/planets/?page=2&format=json"
        }
        it("builds a request for the next page") {
          let request = try! swapi.buildNextRequest(current: baseRequest, type: NamedResult.self).toBlocking().first()!
          expect(request.previous) == "https://swapi.co/api/planets/?page=1&format=json"
        }
        it("sends an error upstream if there are no more pages") {
          baseRequest.next = ""
          let materialized = swapi.buildNextRequest(current: baseRequest, type: NamedResult.self).toBlocking().materialize()
          expect(materialized).to(self.beFailed { _, error  in
            expect(error as? StarWarsAPIError).to(equal(StarWarsAPIError.noPages))
          })
        }
      }
    }
  }
  
  private func beFailed(test: @escaping ([Any], Error) -> Void = { _,_  in }) -> Predicate<MaterializedSequenceResult<StarWarsAPIResponse<NamedResult>>> {
    return Predicate.define("be failed") { expression, message in
      if let actual = try expression.evaluate(),
        case let .failed(elements, error) = actual {
        test(elements, error)
        return PredicateResult(status: .matches, message: message)
      }
      return PredicateResult(status: .fail, message: message)
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
