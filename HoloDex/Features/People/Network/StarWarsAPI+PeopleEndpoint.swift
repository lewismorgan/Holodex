//
//  StarWarsAPI+PeopleEndpoint.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import RxSwift

extension StarWarsAPI: PeopleEndpoint {
  public func getAll() -> Observable<[Person]> {
    return self.createPageRequest(endpoint: "people", from: 1, to: nil, type: Person.self).scan([Person](), accumulator: { seed, latest in
      return seed + latest
      })
  }

  public func getPeople(from page: Int) -> Observable<[Person]> {
    return self.createPageRequest(endpoint: "people", from: page, to: page, type: Person.self)
  }

  public func getPerson(from personId: Int) -> Observable<Person> {
    return self.createRequest(endpoint: "people/\(personId)", type: Person.self)
  }
}
