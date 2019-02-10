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
      var endpoint: String = ""

      beforeEach {
        swapi = StarWarsAPI()
        endpoint = "planets"
      }

      describe("building a request") {
        it("creates a request to the API") {
          let result = try! swapi.buildRequest(endpoint: "\(endpoint)/1/", type: NamedResult.self).toBlocking().first()!
          expect(result.name) == "Tatooine"
        }
      }
      
      describe("building a next page request") {
        let nPages = 3
        it("builds a paged request for 3 pages") {
          let trigger = PublishSubject<Void>()
          let request = swapi.buildPageRequest(endpoint: endpoint, page: 1,
                                               loadNext: trigger.asObservable().startWith(()), type: NamedResult.self).take(nPages)
          
          let items = try! request.toBlocking().toArray()
          
          // There should be nPages of arrays emitted by the stream
          expect(items.count) == nPages
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
