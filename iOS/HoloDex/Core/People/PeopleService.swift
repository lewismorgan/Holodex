//
//  PeopleService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/2/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import RxSwift

/// Describes a PeopleService
protocol PeopleService {
  func fetchPeople(page: Int) -> Single<[Person]>
  func fetchMultiplePeople(startPage: Int, endPage: Int) -> Observable<[Person]>
}
