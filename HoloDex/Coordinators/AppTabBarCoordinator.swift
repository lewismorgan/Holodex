//
//  AppTabBarCoordinator.swift
//  HoloDex
//
//  Created by Lewis Morgan on 1/25/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit
import XCoordinator
import People

class AppTabBarCoordinator: TabBarCoordinator<AppRoute> {
  private let peopleRouter: AnyRouter<PeopleListRoute>

  // MARK: - Init

  // MARK: - TODO: Add tab bar items to coordinators generated vc's

  init() {
    self.peopleRouter = PeopleListCoordinator().anyRouter

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
