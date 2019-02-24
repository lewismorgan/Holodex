//
//  RandomPeopleEndpointTests.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/15/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Nimble
@testable import People
import Quick
import RxBlocking
import RxSwift

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
          expect(person?.birthYear).toNot(beEmpty())
          expect(person?.gender).toNot(beEmpty())
          expect(person?.hairColor).toNot(beEmpty())
          expect(person?.height).toNot(beEmpty())
          expect(person?.homeworld).toNot(beEmpty())
          expect(person?.eyeColor).toNot(beEmpty())
        }
      }
      describe("getting a list of random people from a page") {
        it("emits a list of 10+ random people") {
          let observable = people.getPeople(from: 1)

          let persons = try! observable.toBlocking().first()!

          expect(persons).toNot(beNil())
          expect(persons.count) == 10
        }
      }
      describe("getting all people") {
        it("emits 5 arrays of people") {
          let observable = people.getAll()

          let arrays = try! observable.toBlocking().toArray()

          expect(arrays.count) == 5
        }
      }
    }
  }
}
