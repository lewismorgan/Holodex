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

// ONLY TEST PUBLIC METHODS !

class StarWarsAPITests: QuickSpec {
  override func spec() {
    describe("a Star Wars API") {
      var swapi: StarWarsAPI!

      beforeEach {
        swapi = StarWarsAPI()
      }

      describe("building requests") {
        it("creates a request to the API") {
          let result = try! swapi.buildRequest(endpoint: "planets")
            .toBlocking()
            .first()!
          expect(result.results.count) != 0
        }
      }
    }
  }
}
