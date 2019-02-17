//
//  PersonListViewModelImpl.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import People
import RxSwift
import XCoordinator

class PersonListViewModelImpl: PersonListViewModel {

  // PersonListViewModel

  let people: Variable<[Person]> = Variable<[Person]>([])
  let query: Variable<String> = Variable<String>("")
  var filtered: Observable<[Person]> {
    return filteredSubject.asObservable()
  }
  let loading: Variable<Bool> = Variable<Bool>(true)

  // MARK: - Private
  private let filteredSubject = ReplaySubject<[Person]>.create(bufferSize: 1)
  private let router: AnyRouter<PeopleListRoute>
  private let bag = DisposeBag()

  // MARK: - Init

  init(router: AnyRouter<PeopleListRoute>,
       endpoint: PeopleEndpoint) {
    self.router = router

    // Share the stream so there aren't more than 1 network requests
    let peopleStream = endpoint.getAll().share()

    // Bind to People
    peopleStream.scan([Person](), accumulator: { seed, acc  in
        return seed + acc
    }).bind(to: people)
      .disposed(by: bag)

    // Bind to Loading
    peopleStream.reduce(0, accumulator: { seed, acc in
      return seed + acc.count
    }).flatMap { _ in return Observable.just(false) }
      .debug("🚀")
      .bind(to: loading)
      .disposed(by: bag)

    // Bind to filteredSubject
    Observable.combineLatest(people.asObservable(),
                             query.asObservable()) { [unowned self] people, searchTerm -> [Person] in
      return self.filterPeople(with: people, query: searchTerm)
    }.asDriver(onErrorJustReturn: [])
      .drive(filteredSubject)
      .disposed(by: bag)
  }

  // MARK: - Private Functions

  /// Returns an array of people with names that match the query string, by first or last name
  private func filterPeople(with people: [Person], query: String) -> [Person] {
    guard !query.isEmpty else {
      return people
    }

    let filtered: [Person] = people.filter { person in
      guard let name = person.name else {
        return false
      }
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
  func onSelected(person: Person) {
    router.trigger(.person(person), with: .init(animated: true))
  }
}
