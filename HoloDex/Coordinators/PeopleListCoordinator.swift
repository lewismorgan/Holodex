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
      let storyboard = UIStoryboard(name: "PersonListStoryboard", bundle: nil)
      let viewController = storyboard.instantiateViewController(withIdentifier: "PersonList")
      let viewModel = PersonListViewModelImpl(router: self.anyRouter,
                                              endpoint: endpoint)
      guard let bindable = viewController as? PersonListViewController else {
        fatalError("Expected viewcontroller to be a PersonListViewController")
      }
      bindable.bind(to: viewModel)

      return .push(viewController)
    case .person(let person):
      let viewModel = PersonDetailViewModelImpl(router: self.anyRouter)
      viewModel.person.value = person

      return .push(PersonDetailViewController(model: viewModel))
    }
  }
}
