//
//  DependenciesContainer.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Katana
import Tempura

final class DependenciesContainer: NavigationProvider {
  let dispatch: StoreDispatch

  var navigator: Navigator = Navigator()
  var getAppState: () -> AppState
  var getState: () -> State {
    return self.getAppState
  }

  required init(dispatch: @escaping StoreDispatch, getAppState: @escaping () -> AppState) {
    self.dispatch = dispatch
    self.getAppState = getAppState
    debugPrint("setup called")
  }
}

extension DependenciesContainer {
  // Convert State to an AppState type and pass it to the init in DependenciesContainer
  convenience init(dispatch: @escaping StoreDispatch, getState: @escaping () -> State) {
    let getAppState: () -> AppState = {
      guard let state = getState() as? AppState else {
        fatalError("Wrong State Type")
      }
      return state
    }

    self.init(dispatch: dispatch, getAppState: getAppState)
  }
}
