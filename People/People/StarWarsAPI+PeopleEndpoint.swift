//
//  StarWarsAPI+PeopleEndpoint.swift
//  People
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Networking
import RxSwift

extension StarWarsAPI: PeopleEndpoint {
  func getPeople(from page: Int) -> Observable<[Person]> {
    return self.buildPageRequest(endpoint: "people", page: page, type: Person.self).map { $0.results }
  }
  
  func getPerson(from id: Int) -> Observable<Person> {
    return self.buildRequest(endpoint: "people/\(id)", type: Person.self)
  }
}
