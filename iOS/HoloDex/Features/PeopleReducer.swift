//
//  PeopleReducer.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift

public struct PeopleReducer {
  public static func handleAction(action: Action, state: PeopleState?) -> PeopleState {
    var state = state ?? initPeopleState()

    switch action {
    case _ as ReSwiftInit:
      break
    case let action as PeopleActions.LoadPeople:
      state.people = action.results
    default:
      debugPrint("Can't handle action \(action)")
    }

    return state
  }

  private static func initPeopleState() -> PeopleState {
    // TODO Init People State
    return PeopleState()
  }
}
