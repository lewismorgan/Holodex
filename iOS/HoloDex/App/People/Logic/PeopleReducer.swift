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
      // Nothing to do as of now... Maybe in the future !
      break
    case .success(let people):
      if state.people == nil {
        state.people = people
      } else {
        state.people?.append(contentsOf: people)
      }
    case .failure(let error):
      fatalError("Failure trying to obtain people: \(error)")
    }
  }

  private static func onDetailPerson(_ action: PeopleActions.DetailPerson, _ state: inout PeopleState) {
    switch action {
    case .show(let person):
      guard let name = person.name else {
        fatalError("LKSDFJ")
      }
      debugPrint("Will detail \(name)")
      break
    case .dismiss:
      break
    }
  }
  
  private static func initPeopleState() -> PeopleState {
    return PeopleState()
  }
}
