//
//  PeopleActions.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Core
import People
import ReSwift

struct PeopleActions {
  enum FetchPeople: Action {
    case request
    case success(people: [Person])
    case failure(error: Error)
  }
  enum DetailPerson: Action {
    case show(Person)
    case dismiss
  }
}
