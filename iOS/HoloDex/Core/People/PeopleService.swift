//
//  PeopleService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/2/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Promises

/// Describes a PeopleService
protocol PeopleService {
  func fetchPeople(page: Int) -> Promise<[Person]>
  func fetchAllPeople() -> Promise<[Person]>
}
