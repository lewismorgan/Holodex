//
//  PeopleEndpoint.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import RxSwift

protocol PeopleEndpoint: Endpoint {
  func getAll() -> Observable<[Person]>
  func getPeople(from page: Int) -> Observable<[Person]>
  func getPerson(from personId: Int) -> Observable<Person>
}
