//
//  PeopleAPI.swift
//  People
//
//  Created by Lewis Morgan on 2/10/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import RxSwift

public protocol PeopleAPI {
  func fetchPeople(starting page: Int) -> Observable<([Person], Int)>
  func fetchPerson(from id: Int) -> Observable<Person>
}
