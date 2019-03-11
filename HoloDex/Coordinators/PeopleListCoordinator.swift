//
//  PeopleListCoordinator.swift
//  HoloDex
//
//  Created by Lewis Morgan on 1/28/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Network
import People
import UIKit
import XCoordinator

enum PeopleListRoute: Route {
  case home
  case persons
  case person(Person)
}

class PeopleListCoordinator: NavigationCoordinator<PeopleListRoute> {
  private let endpoint: PeopleEndpoint!

  private var detailView: PersonDetailViewController?
  private var listView: PersonListViewController?

  // MARK: - Init

  init(endpoint: PeopleEndpoint) {
    self.endpoint = endpoint
    super.init(initialRoute: .home)
  }

  // MARK: - Overrides

  override func prepareTransition(for route: PeopleListRoute) -> NavigationTransition {
    switch route {
    case .home, .persons:
      if let viewController = listView {
        return .push(viewController)
      } else {
        // View has not be loaded yet

        let viewController = PersonListViewController()
        let viewModel = PersonListViewModelImpl(router: self.anyRouter)
        viewController.bind(to: viewModel)

        // Trigger data update
        viewModel.requestUpdate(endpoint: endpoint)

        self.listView = viewController
        return .push(viewController)
      }
    case .person(let person):
      if let viewController = detailView, let model = viewController.viewModel {
        model.person.value = person

        return .push(viewController)
      } else {
        // View has not been loaded yet

        let viewController = PersonDetailViewController()
        let viewModel = PersonDetailViewModelImpl(router: self.anyRouter)
        viewController.bind(to: viewModel)

        // Emit value only after binding
        viewModel.person.value = person

        self.detailView = viewController
        return .push(viewController)
      }
    }
  }
}
