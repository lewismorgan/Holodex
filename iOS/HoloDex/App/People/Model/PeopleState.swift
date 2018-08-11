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

public struct PeopleState: StateType {
  var people: [Person]?
}

protocol PeopleStateStore {
  var peopleState: PeopleState { get set }
}
