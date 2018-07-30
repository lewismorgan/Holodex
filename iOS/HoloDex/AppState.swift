//
//  AppState.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift
import ReSwiftRouter

struct AppState: StateType, HasNavigationState, PeopleStateStore {
  // other application state
  var navigationState: NavigationState
  var peopleState: PeopleState
}
