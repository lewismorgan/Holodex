//
//  StaticPeopleService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/2/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

/// A PeopleService that returns static data

import RxSwift

class StaticPeopleService: PeopleService {
  func fetchPeople(page: Int) -> Single<[Person]> {
    var items = [Person]()
    if page == 0 {
      items.append(createJyn())
    } else {
      items.append(createAnakin())
    }
    return Single.just(items)
  }

  func fetchPeople(startPage: Int, endPage: Int) -> Observable<[[Person]]> {
    return Observable.just([[createAnakin(), createJyn()]])
  }

  private func createAnakin() -> Person {
    var anakin = Person()
    anakin.name = "Anakin Skywalker"
    return anakin
  }

  private func createJyn() -> Person {
    var jyn = Person()
    jyn.name = "Jyn Erso"
    return jyn
  }
}
