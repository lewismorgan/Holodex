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

  // TODO: Add tab bar items to coordinators generated vc's

  init() {
    self.peopleRouter = PeopleListCoordinator(endpoint: RandomPeopleEndpoint()).anyRouter

    super.init(tabs: [peopleRouter], select: peopleRouter)
  }

  // MARK: - Overrides

  override func prepareTransition(for route: AppRoute) -> TabBarTransition {
    switch route {
    case .people:
      return .select(peopleRouter)
    }
  }
}
