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

  // MARK: - Input

  //var search: Driver<String>

  // MARK: - Output

  var people: Observable<[Person]>

  // MARK: - Private

  private let router: AnyRouter<PeopleListRoute>

  init(router: AnyRouter<PeopleListRoute>,
       swapi: StarWarsAPI) {
    self.router = router

    //self.search = search
    self.people = swapi.fetchMultiplePeople(startPage: 0, endPage: 5)
  }
}
