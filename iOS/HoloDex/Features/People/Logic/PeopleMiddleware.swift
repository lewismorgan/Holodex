//
//  PeopleMiddleware.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/30/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift

let disposeSingleObservers = DisposeBag()

func fetchPeople(peopleService: PeopleService) -> MiddlewareItem {
  return { (action: Action, dispatch: @escaping DispatchFunction) in
    guard let action = action as? PeopleActions.FetchPeople,
      case .request = action else { return }

    debugPrint("Inside middleware")
    peopleService.fetchPeople(startPage: 1, endPage: 2).subscribe { event in
      switch event {
      case .next(let element):
        for people in element {
          dispatch(PeopleActions.FetchPeople.success(people: people))
        }
      case .error(let error):
        dispatch(PeopleActions.FetchPeople.failure(error: error))
      case .completed:
        break
      }
    }.disposed(by: disposeSingleObservers)
  }
}
