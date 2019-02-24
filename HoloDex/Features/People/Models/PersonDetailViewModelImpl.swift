//
//  PersonDetailViewModelImpl.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/16/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import People
import RxSwift
import XCoordinator

class PersonDetailViewModelImpl: PersonDetailViewModel {

  // MARK: - Input

  var person: Variable<Person> = Variable(Person())

  // MARK: - Private
  private let router: AnyRouter<PeopleListRoute>!

  // MARK: - Init
  init(router: AnyRouter<PeopleListRoute>) {
    self.router = router
  }
}
