//
//  PeopleCoordinator.swift
//  HoloDex
//
//  Created by Lewis Morgan on 1/28/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit
import XCoordinator
import People

enum PeopleRoute: Route {
  case home
  case detail(Person)
}

class PeopleCoordinator: NavigationCoordinator<PeopleRoute> {
  init() {
    super.init(initialRoute: .home)
  }

  override func prepareTransition(for route: PeopleRoute) -> NavigationTransition {
    switch route {
    case .home:
      let viewController = PeopleViewController()
      return .push(viewController)
    case .detail(let person):
      let viewController = PersonDetailViewController(person: person)
      return .push(viewController)
    }
  }
}
