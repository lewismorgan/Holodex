//
//  PersonListViewModelImpl.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import RxSwift
import RxCocoa
import People
import XCoordinator

class PersonListViewModelImpl: PersonListViewModel {

  // MARK: - Input

  var search: Driver<String>

  // MARK: - Output

  var people: Observable<[Person]>

  // MARK: - Private

  private let router: AnyRouter<PeopleListRoute>

  init(router: AnyRouter<PeopleListRoute>,
       search: Driver<String>,
       people: Observable<[Person]>) {
    self.router = router

    self.search = search
    self.people = people
  }
}
