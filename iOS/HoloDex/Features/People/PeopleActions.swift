//
//  PeopleActions.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift
import RxSwift

// https://github.com/cardoso/ReduxMovieDB/blob/master/ReduxMovieDB/ActionCreators.swift

public struct PeopleActions {
  public struct SetPeople: Action {
    let result: Result<[Person]>
  }

  public static func fetchPeople<T: StateType>(store: Store<T>) -> Action {
    // TODO: Make a request to the Star Wars API for the list of people
    var people = [Person]()
    var jyn = Person()
    jyn.name = "Jyn Erso"
    jyn.gender = "Female"
    people.append(jyn)
    DispatchQueue.main.async {
      store.dispatch(PeopleActions.SetPeople(result: Result.success([jyn, jyn, jyn, jyn, jyn, jyn, jyn, jyn])))
    }

    return StandardAction(type: "PEOPLE_FETCHING")
  }
}
