//
//  StaticPeopleService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/2/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import RxSwift

/// A PeopleService that returns static data
public class StaticPeopleService: PeopleService {

  public init() {
  }

  public func fetchPeople(page: Int) -> Single<[Person]> {
    var items = [Person]()

    for item in 1...10 {
      if item % 2 == 1 {
        items.append(createAnakin())
      } else {
        items.append(createJyn())
      }
    }

    return Single.just(items)
  }

  public func fetchMultiplePeople(startPage: Int, endPage: Int) -> Observable<[Person]> {
    var people = [Observable<[Person]>]()
    for page in startPage...endPage {
      people.append(fetchPeople(page: page).asObservable())
    }
    return Observable.merge(people)
  }

  private func createPerson(_ name: String) -> Person {
    var rando = Person()
    rando.name = name
    return rando
  }

  private func createAnakin() -> Person {
    return createPerson("Anakin Skywalker")
  }

  private func createJyn() -> Person {
    return createPerson("Jyn Erso")
  }
}
