//
//  PeopleAPIServiceSpec.swift
//  HoloDexUnitTests
//
//  Created by Lewis Morgan on 8/9/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

@testable import HoloDex
import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking
import RxNimble

class StaticPeopleServiceSpec: QuickSpec {
  override func spec() {
    super.spec()

    let peopleService = StaticPeopleService()

    describe("fetching people by page") {
      context("when passing in a valid page number") {
        let people = peopleService.fetchPeople(page: 1).asObservable()
        it("emits a single, observable, array of Person") {
          expect(people).first.toNot(beNil())
        }
        it("contains 10 items") {
          expect(people).array.to(haveCount(1))
          expect(people).first.to(haveCount(10))
        }
      }
    }

//    describe("fetching multiple people from a start page to end page") {
//    }
  }
}
