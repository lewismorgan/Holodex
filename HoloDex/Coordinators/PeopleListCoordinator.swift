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

  // MARK: - Init

  init(endpoint: PeopleEndpoint) {
    self.endpoint = endpoint
    super.init(initialRoute: .home)
  }

  // MARK: - Overrides

  override func prepareTransition(for route: PeopleListRoute) -> NavigationTransition {
    switch route {
    case .home, .persons:
      let viewController = PersonListViewController()
      let viewModel = PersonListViewModelImpl(router: self.anyRouter,
                                              endpoint: endpoint)
      viewController.bind(to: viewModel)

      return .push(viewController)
    case .person(let person):
      let viewController = PersonDetailViewController()
      let viewModel = PersonDetailViewModelImpl(router: self.anyRouter)
      viewModel.person.value = person

      viewController.bind(to: viewModel)

      return .push(viewController)
    }
  }

  override func generateRootViewController() -> UINavigationController {
    // TODO: Don't override the function, as delegate will not work, move to init method of tab coordinator
    let controller = super.generateRootViewController()
    controller.tabBarItem = UITabBarItem(title: "People", image: nil, tag: 0)
    return controller
  }
}
