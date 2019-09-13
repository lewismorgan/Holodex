//
//  PeopleListViewModel.swift
//  HoloDex
//
//  Created by Lewis Morgan on 9/12/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Combine
import RxSwift
import SwiftUI

class PeopleListViewModel: ObservableObject {
  @Published var people: [Person] = []
  @Published var loading: Bool

  private let service: PersonService
  private let bag = DisposeBag()

  init(service: PersonService) {
    self.service = service
    self.loading = false
  }

  func request() {
    loading = true
    service.getAll().subscribe(
      onNext: { updated in
      DispatchQueue.main.async {
        // TODO: When this is being added, show a loading ticker
        self.people = updated
      }
      }, onDisposed: {
      DispatchQueue.main.async {
        self.loading = false
      }
      }).disposed(by: bag)
  }
}
