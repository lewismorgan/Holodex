//
//  StarWarsAPI+PeopleEndpoint.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import RxSwift

extension StarWarsAPI: PersonService {
  public func getAll() -> Observable<[Person]> {
    return self.createPageRequest(endpoint: "people", from: 1, until: nil,
                                  type: Person.self)
  }

  public func getPeople(from page: Int) -> Observable<[Person]> {
    return self.createPageRequest(endpoint: "people", from: page, until: page, type: Person.self)
  }

  public func getPerson(from personId: Int) -> Observable<Person> {
    return self.createRequest(endpoint: "people/\(personId)", type: Person.self)
  }
}
