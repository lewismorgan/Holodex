//
//  StaticPeopleEndpoint.swift
//  People
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Networking
import RxSwift

/// People Endpoint that does not make any actual network requests
public class StaticPeopleEndpoint: PeopleEndpoint {
  func getPeople(from page: Int) -> Observable<[Person]> {
    return Observable.empty()
  }
  
  func getPerson(from id: Int) -> Observable<Person> {
    return Observable.empty()
  }
}
