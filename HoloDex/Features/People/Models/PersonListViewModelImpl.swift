//
//  PersonListViewModelImpl.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Combine
import RxCocoa
import RxSwift

class PersonListViewModelImpl: PersonListViewModel {

  // MARK: - Public
  // Input
  @Published var query = ""

  // Output
  @Published var people: [Person] = []
  @Published var filtered: [Person] = []
  @Published var loading = false

  // MARK: - Private
  private let bag = DisposeBag()

  // MARK: - Functions

  init() {}

  /// Returns an array of people with names that match the query string, by first or last name
  private func filterPeople(with people: [Person], query: String) -> [Person] {
    guard !query.isEmpty else {
      return people
    }

    let filtered: [Person] = people.filter { person in
      let name = person.name

      // Only check for the suffix or prefix in the string, could do contains but that may confuse the user
      let matches = name.hasSuffix(query) || name.hasPrefix(query)

      // The user could be searching for a portion of the last name, so grab that if they have one
      if !matches && name.contains(" ") {
        let lastName = name.split(separator: " ")[1]
        // Only checking for the prefix and suffix is good enough
        return lastName.hasPrefix(query) || lastName.hasSuffix(query)
      }
      return matches
    }

    return filtered
  }

  // MARK: - PersonListViewModel
  func requestUpdate(endpoint: PeopleEndpoint) {
    endpoint.getAll().scan([Person](), accumulator: { seed, acc in
      return acc + seed
    }).subscribe(onNext: { updatedData in
      self.people = updatedData
    }).disposed(by: bag)
  }

  func onSelected(person: Person) {
    //router.trigger(.person(person), with: .init(animated: true))
  }
}
