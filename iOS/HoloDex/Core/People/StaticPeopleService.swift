//
//  StaticPeopleService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/2/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

/// A PeopleService that returns static data

import Promises

class StaticPeopleService: PeopleService {
  func fetchPeople(page: Int) -> Promise<[Person]> {
    return Promise { fullfill, _ in
      if page == 0 {
        fullfill([self.createAnakin()])
      } else {
        fullfill([self.createJyn()])
      }
    }
  }

  func fetchAllPeople() -> Promise<[Person]> {
    return Promise { fullfill, _ in
      fullfill([self.createJyn(), self.createAnakin()])
    }
  }

  private func createAnakin() -> Person {
    var anakin = Person()
    anakin.name = "Anakin Skywalker"
    return anakin
  }

  private func createJyn() -> Person {
    var jyn = Person()
    jyn.name = "Jyn Erso"
    return jyn
  }
}
