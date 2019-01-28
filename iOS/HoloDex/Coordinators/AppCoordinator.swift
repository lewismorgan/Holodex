//
//  AppCoordinator.swift
//  HoloDex
//
//  Created by Lewis Morgan on 1/25/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit
import XCoordinator

class AppTabCoordinator: TabBarCoordinator<AppRoute> {
  let peopleViewController = PeopleViewController()

  init() {
    super.init(tabs: [peopleViewController], select: 0)
  }

  override func prepareTransition(for route: AppRoute) -> TabBarTransition {
    switch route {
    case .home, .people:
      return .select(peopleViewController)
    }
  }
}
