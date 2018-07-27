//
//  HDStatefulViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift

/// A view controller that subscribes to a store and has state that it must conform to
class HDStatefulViewController<StoreStateType: StateType, State: StateType>:
    HDViewController<PeopleView, StoreStateType>, StoreSubscriber {

  // The `state` argument needs to match the selected substate
  func newState(state: State) {
    fatalError("newState(state:) is not implemented")
  }
}
