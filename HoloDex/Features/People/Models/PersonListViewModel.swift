//
//  PersonListViewModel.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import RxSwift

protocol PersonListViewModel {

  // MARK: - Input
  var query: BehaviorSubject<String> { get }
//  var request: BehaviorSubject<Bool> { get }

  // MARK: - Output
  var people: BehaviorSubject<[Person]> { get }
  var filtered: Observable<[Person]> { get }
  var loading: BehaviorSubject<Bool> { get }

  func onSelected(person: Person)
  func requestUpdate(endpoint: PeopleEndpoint)
}
