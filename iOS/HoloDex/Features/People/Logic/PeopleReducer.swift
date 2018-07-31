//
//  PeopleReducer.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift

public struct PeopleReducer {
  public static func handleAction(_ action: Action, state: PeopleState?) -> PeopleState {
    var state = state ?? initPeopleState()

    switch action {
    case _ as ReSwiftInit:
      break

    case let action as PeopleActions.FetchPeople:
      onFetchPeople(action, &state)
    default:
      break
    }

    return state
  }

  private static func onFetchPeople(_ action: PeopleActions.FetchPeople, _ state: inout PeopleState) {
    switch action {
    case .request:
      debugPrint("Requesting People")
    case .success(let people):
      state.people = people
    case .failure(let error):
      fatalError("Failure trying to obtain people: \(error)")
    }
  }

  private static func initPeopleState() -> PeopleState {
    return PeopleState()
  }
}
