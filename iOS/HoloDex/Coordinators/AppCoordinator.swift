//
//  AppCoordinator.swift
//  HoloDex
//
//  Created by Lewis Morgan on 1/25/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit
import XCoordinator

class AppCoordinator: NavigationCoordinator<AppRoute> {
  init() {
    super.init(initialRoute: .home)
  }

  override func prepareTransition(for route: AppRoute) -> NavigationTransition {
    switch route {
    case .home, .people:
      let viewController = PeopleViewController()
      return .push(viewController)
    case .person(let person):
      let viewController = PersonDetailViewController(person: person)
      return .push(viewController)
    }
  }
}
