//
//  StarWarsAPI+PeopleService.swift
//  People
//
//  Created by Lewis Morgan on 2/10/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Networking
import RxSwift

extension StarWarsAPI: PeopleAPI {
  public func fetchPeople(starting page: Int) -> Observable<([Person], Int)> {
    let request = buildRequest(endpoint: "people", type: Person.self).map { response in
      return (response, response.results)
    }
    return Observable.just(([Person()], 1))
  }
  
  public func fetchPerson(from id: Int) -> Observable<Person> {
    return buildRequest(endpoint: "people", type: Person.self)
      .map { $0.results }
      .map { results in
        if (results.count > 1) {
          throw PeopleError.moreThanOneId
        } else  { return results[0] }
      }
  }
}

enum PeopleError: Error {
  case moreThanOneId
}
