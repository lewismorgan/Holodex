//
//  PersonListViewModel.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import People
import RxSwift

protocol PersonListViewModel {

  // MARK: - Input
  var query: Variable<String> { get }
  var request: Variable<Bool> { get }

  // MARK: - Output
  var people: Variable<[Person]> { get }
  var filtered: Observable<[Person]> { get }
  var loading: Variable<Bool> { get }

  func onSelected(person: Person)
}
