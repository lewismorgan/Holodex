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

  private let endpoint: PeopleEndpoint

  private let bag = DisposeBag()
  init(endpoint: PeopleEndpoint) {
    self.endpoint = endpoint
  }

  func request() {
    endpoint.getAll().subscribe(onNext: { updated in
      self.people = updated
    }).disposed(by: bag)
  }
  deinit {
    print("DESTROYING")
  }
}
