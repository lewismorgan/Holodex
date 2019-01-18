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
    case request(page: Int)
    case success(people: [Person], next: Int)
    case failure(error: Error)
  }
  enum DetailPerson: Action {
    case show(person: Person)
    case dismiss
  }
}
