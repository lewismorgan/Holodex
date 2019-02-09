//
//  StaticPeopleService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/2/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Network
import RxSwift

/// Extension method for static data from the StarWarsAPI
public extension StarWarsAPI {

  public func fetchPeople(page: Int) -> Single<([Person], Int?)> {
    var items = [Person]()

    for item in 1...10 {
      if item % 2 == 1 {
        items.append(createAnakin())
      } else {
        items.append(createJyn())
      }
    }

    return Single.just((items, page + 1))
  }

  public func fetchPerson(id: Int) -> PrimitiveSequence<SingleTrait, Person> {
    return Single.just(createAnakin())
  }

  public func fetchMultiplePeople(startPage: Int, endPage: Int) -> Observable<[Person]> {
    var people = [Observable<[Person]>]()
    for page in startPage...endPage {
      people.append(fetchPeople(page: page).map { $0.0 }.asObservable())
    }
    return Observable.merge(people)
  }

  private func createPerson(_ name: String) -> Person {
    var rando = Person()
    rando.name = name
    rando.height = "1337m"
    rando.hairColor = "Blonde"
    rando.mass = "3.14kg"
    rando.birthYear = "2018 BY"
    rando.eyeColor = "Blue"
    rando.homeworld = "Tatooine"
    rando.gender = "Male"
    rando.skinColor = "White"
    return rando
  }

  private func createAnakin() -> Person {
    return createPerson("Anakin Skywalker")
  }

  private func createJyn() -> Person {
    return createPerson("Jyn Erso")
  }
}
