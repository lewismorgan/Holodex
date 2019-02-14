//
//  PeopleEndpoint.swift
//  People
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import RxSwift

protocol PeopleEndpoint {
  func getPeople(from page: Int) -> Observable<[Person]>
  func getPerson(from id: Int) -> Observable<Person>
}
