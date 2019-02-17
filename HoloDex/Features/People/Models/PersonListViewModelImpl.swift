//
//  PersonListViewModelImpl.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import RxSwift
import RxCocoa
import XCoordinator
import Network
import People

class PersonListViewModelImpl: PersonListViewModel {

  // PersonListViewModel

  let people: Variable<[Person]> = Variable<[Person]>([])
  let query: Variable<String> = Variable<String>("")
  var filtered: Observable<[Person]> {
    return filteredSubject.asObservable()
  }

  // MARK: - Private
  private let filteredSubject = ReplaySubject<[Person]>.create(bufferSize: 1)
  private let router: AnyRouter<PeopleListRoute>
  private let bag = DisposeBag()

  // MARK: - Init

  init(router: AnyRouter<PeopleListRoute>,
       endpoint: PeopleEndpoint) {
    self.router = router

    Observable.merge(endpoint.getPeople(from: 1), endpoint.getPeople(from: 2))
      .bind(to: people)
      .disposed(by: bag)

    // Create the filteredSubject
    Observable.combineLatest(people.asObservable(),
                             query.asObservable()) { [unowned self] (people, searchTerm) -> [Person] in
      return self.filterPeople(with: people, query: searchTerm)
    }.asDriver(onErrorJustReturn: [])
      .drive(filteredSubject)
      .disposed(by: bag)
  }

  private func filterPeople(with people: [Person], query: String) -> [Person] {
    guard !query.isEmpty else {
      return people
    }

    let filtered: [Person] = people.filter { (person) in
      guard let name = person.name else {
        return false
      }
      return name.hasPrefix(query) || name.hasSuffix(query)
    }

    return filtered
  }

  // MARK: - PersonListViewModel
  func onSelected(person: Person) {
    router.trigger(.person(person), with: .init(animated: true))
  }
}
