//
//  PersonListViewModel.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Combine

protocol PersonListViewModel {
  // MARK: - Input
  var query: String { get set }

  // MARK: - Output
  var people: [Person] { get set }
  var filtered: [Person] { get set }
  var loading: Bool { get set }

  func onSelected(person: Person)
  func requestUpdate(endpoint: PeopleEndpoint)
}
