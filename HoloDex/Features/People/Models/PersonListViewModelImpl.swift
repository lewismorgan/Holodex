//
//  PersonListViewModelImpl.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import RxSwift
import RxCocoa
import XCoordinator
import Network
import People

class PersonListViewModelImpl: PersonListViewModel {

  var people: Variable<[Person]> = Variable<[Person]>([])

  // MARK: - Private

  private let router: AnyRouter<PeopleListRoute>

  private let bag = DisposeBag()

  // MARK: - Init

  init(router: AnyRouter<PeopleListRoute>,
       endpoint: PeopleEndpoint) {
    self.router = router

    Observable.merge(endpoint.getPeople(from: 1), endpoint.getPeople(from: 2))
      .bind(to: people).disposed(by: bag)
  }

  func onSelected(person: Person) {
    router.trigger(.person(person), with: .init(animated: true))
  }
}
