//
//  PeopleMiddleware.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/30/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Foundation
import ReSwift

func fetchPeople(peopleService: PeopleService) -> MiddlewareItem {
  return { (action: Action, dispatch: @escaping DispatchFunction) in
    guard let action = action as? PeopleActions.FetchPeople,
      case .request = action else { return }

    peopleService.fetchPeople()
      .then { dispatch(PeopleActions.FetchPeople.success(people: $0)) }
      .catch { dispatch(PeopleActions.FetchPeople.failure(error: $0)) }
  }
}
