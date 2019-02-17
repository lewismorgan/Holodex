//
//  PersonListViewModel.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import RxSwift
import RxCocoa
import Action
import People

protocol PersonListViewModel {

  // MARK: - Input
  var query: Variable<String> { get }

  // MARK: - Output
  var people: Variable<[Person]> { get }
  var filtered: Observable<[Person]> { get }

  func onSelected(person: Person)
}
