//
//  AppTabBarCoordinator.swift
//  HoloDex
//
//  Created by Lewis Morgan on 1/25/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Networking
import People
import UIKit
import XCoordinator

class AppCoordinator: TabBarCoordinator<AppRoute> {
  private let peopleRouter: AnyRouter<PeopleListRoute>

  // MARK: - Init

  convenience init() {
    let peopleCoordinator = PeopleListCoordinator(endpoint: StarWarsAPI()).anyRouter
    peopleCoordinator.viewController.tabBarItem = UITabBarItem(title: "People", image: nil, tag: 0)

    self.init(peopleRouter: peopleCoordinator.anyRouter)
  }

  init(peopleRouter: AnyRouter<PeopleListRoute>) {
    self.peopleRouter = peopleRouter

    super.init(tabs: [peopleRouter], select: peopleRouter)

    setupView()
  }

  // MARK: - Private Functions
  private func setupView() {
  }

  // MARK: - TabBarCoordinator

  override func prepareTransition(for route: AppRoute) -> TabBarTransition {
    switch route {
    case .people:
      return .select(peopleRouter)
    }
  }
}
