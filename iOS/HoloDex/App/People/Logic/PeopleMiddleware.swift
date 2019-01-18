//
//  PeopleMiddleware.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/30/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import People
import ReSwift
import RxSwift

let disposeSingleObservers = DisposeBag()

func fetchPeople(peopleService: PeopleService) -> MiddlewareItem {
  return { (action: Action, dispatch: @escaping DispatchFunction) in
    guard let action = action as? PeopleActions.FetchPeople,
      case .request(let page) = action else { return }
    peopleService.fetchPeople(page: page).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
      .subscribe { event in
        switch event {
        case .success(let element):
          // TODO: Convert element.1 to an integer
          dispatch(PeopleActions.FetchPeople.success(people: element.0, next: 5))
        case .error(let error):
          dispatch(PeopleActions.FetchPeople.failure(error: error))
        }
      }.disposed(by: disposeSingleObservers)
  }
}
