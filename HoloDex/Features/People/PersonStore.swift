//
//  PersonStore.swift
//  HoloDex
//
//  Created by Lewis Morgan on 9/12/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Combine
import RxSwift

final class PersonStore: ObservableObject {
  @Published var people: [PersonCellModel] = []
  @Published var requested: Bool

  private var persons: [Person]
  private var unfiltered: [PersonCellModel] = []
  private let service: PersonService
  private let bag = DisposeBag()

  init(service: PersonService) {
    self.service = service
    self.requested = false
    self.persons = []
  }

  func request() {
    if requested { return }

    requested = true

    service.getAll()
      .observeOn(MainScheduler.asyncInstance)
      .subscribe(onNext: { received in
        self.updatePeople(new: received)
      }, onDisposed: {
        self.requested = false
      }).disposed(by: bag)
  }

  func updatePeople(new: [Person]) {
    let models = new.map { PersonCellModel(for: $0) }
    persons.append(contentsOf: new)
    people.append(contentsOf: models)
  }
}
