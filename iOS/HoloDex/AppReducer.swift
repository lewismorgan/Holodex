//
//  AppReducer.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
  return AppState(
    navigationState: NavigationReducer.handleAction(action, state: state?.navigationState)
  )
}
