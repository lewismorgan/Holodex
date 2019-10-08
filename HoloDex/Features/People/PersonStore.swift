//
//  PersonStore.swift
//  HoloDex
//
//  Created by Lewis Morgan on 9/12/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Combine
import Foundation
import RxSwift
import SwiftUI

final class PersonStore: ObservableObject {
  let people: CurrentValueSubject<[PersonCellModel], Never> = CurrentValueSubject<[PersonCellModel], Never>([])
  @Published var filteredPeople: [PersonCellModel] = []
  @Published var requested: Bool = false
  @Published var query: String = ""

  private var persons: [Person] = []
  private var unfiltered: [PersonCellModel] = []
  private let service: PersonService
  private let bag = DisposeBag()

  init(service: PersonService) {
    self.service = service
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
    persons.append(contentsOf: new)
    people.send(people.value + new.map { PersonCellModel(for: $0) })
  }

  func search(query: String) {
    //$people.filter( { $0.contains(where: { $0.name == query })}).collect().
  }
}
