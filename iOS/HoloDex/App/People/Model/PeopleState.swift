//
//  PeopleState.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Core
import People
import ReSwift

public enum PeopleState: StateType {
  var currentPeople: [Person] {
    switch self {
    case .populated(let people):
      return people
    case .paging(let people, _):
      return people
    default:
      return []
    }
  }

  case loading
  case error
  case empty
  case paging(people: [Person], next: Int)
  case populated(people: [Person])
  case viewing(person: Person)
}

/// A store that contains PeopleState
protocol PeopleStateStore {
  var peopleState: PeopleState { get set }
}
