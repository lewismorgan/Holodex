//
//  PeopleEndpoint.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import RxSwift

protocol PersonService: Service {
  /// Emits a continuing array of Person until there are no more pages left
  func getAll() -> Observable<[Person]>
  /// Emits all the people from a page
  func getPeople(from page: Int) -> Observable<[Person]>
  /// Emits a person with the given id
  func getPerson(from personId: Int) -> Observable<Person>
}
