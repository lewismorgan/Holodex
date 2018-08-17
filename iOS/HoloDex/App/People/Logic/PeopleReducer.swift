//
//  PeopleReducer.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Core
import People
import ReSwift

public struct PeopleReducer {
  public static func handleAction(_ action: Action, state: PeopleState?) -> PeopleState {
    var state = state ?? initPeopleState()

    switch action {
    case _ as ReSwiftInit:
      break

    case let action as PeopleActions.FetchPeople:
      onFetchPeople(action, &state)

    case let action as PeopleActions.DetailPerson:
      onDetailPerson(action, &state)

    default:
      break
    }

    return state
  }

  private static func onFetchPeople(_ action: PeopleActions.FetchPeople, _ state: inout PeopleState) {
    switch action {
    case .request:
      state = PeopleState.loading
      debugPrint("onFetchPeople is request")
    case .success(let tuple):
      if tuple.next > 0 {
        state = PeopleState.paging(people: tuple.people, next: tuple.next)
      } else {
        state = PeopleState.populated(people: tuple.people)
      }
    case .failure(let error):
      state = PeopleState.error
      fatalError("Failure trying to obtain people: \(error)")
    }
  }

  private static func onDetailPerson(_ action: PeopleActions.DetailPerson, _ state: inout PeopleState) {
    switch action {
    case .show(let person):
      state = PeopleState.viewing(person: person)
    case .dismiss:
      break
    }
  }

  private static func initPeopleState() -> PeopleState {
    return PeopleState.empty
  }
}
