//
//  RandomPeopleEndpoint.swift
//  People
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Networking
import RxSwift

/// Provides randomized data in conformance with the PeopleEndpoint protocol
public class RandomPeopleEndpoint: PeopleEndpoint {
  public init() {
  }

  public func getPeople(from page: Int) -> Observable<[Person]> {
    return Observable.empty()
  }

  public func getPerson(from id: Int) -> Observable<Person> {
    return Observable.empty()
  }

  private func createPerson(name: String) -> Person {
    var person = Person()

    person.name = name

    return person
  }
}
