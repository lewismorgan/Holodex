//
//  RandomPeopleEndpointTests.swift
//  PeopleTests
//
//  Created by Lewis Morgan on 2/15/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

@testable import People
import Quick
import Nimble
import RxSwift
import RxBlocking

class RandomPeopleEndpointTests: QuickSpec {
  override func spec() {
    describe("a RandomPeopleEndpoint") {
      // MARK: - Setup
      var people: RandomPeopleEndpoint!
      beforeEach {
        people = RandomPeopleEndpoint()
      }
      
      // MARK: - Tests
      
      describe("getting a person") {
        it("emits a random person") {
          let observable = people.getPerson(from: 1)
          
          let person = try! observable.toBlocking().first()
          
          expect(person?.name).toNot(beEmpty())
        }
      }
      describe("getting a list of random people from a page") {
        it("emits a list of random people") {
          let observable = people.getPeople(from: 1)
          
          let persons = try! observable.toBlocking().first()
          
          expect(persons).toNot(beNil())
          expect(persons).toNot(beEmpty())
        }
      }
    }
  }
}
