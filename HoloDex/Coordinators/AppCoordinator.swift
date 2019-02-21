//
//  AppTabBarCoordinator.swift
//  HoloDex
//
//  Created by Lewis Morgan on 1/25/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Networking
import People
import Swinject
import UIKit
import XCoordinator

class AppCoordinator: TabBarCoordinator<AppRoute> {
  private let peopleRouter: AnyRouter<PeopleListRoute>

  // MARK: - Init

  convenience init(container: Swinject.Container) {
    guard let endpoint = container.resolve(PeopleEndpoint.self) else {
      fatalError("🛑 Container has no PeopleEndpoint registered")
    }

    let peopleCoordinator = PeopleListCoordinator(endpoint: endpoint).anyRouter
    peopleCoordinator.viewController.tabBarItem = createTabBarItem(tabBarSystemItem: .contacts, tag: 0)

    self.init(peopleRouter: peopleCoordinator.anyRouter)
  }

  init(peopleRouter: AnyRouter<PeopleListRoute>) {
    self.peopleRouter = peopleRouter

    super.init(tabs: [peopleRouter], select: peopleRouter)

    setupView()
  }

  // MARK: - Private Functions
  private func setupView() {
    let tabBar = self.rootViewController.tabBar
    tabBar.barStyle = .black

    tabBar.tintColor = Colors.primaryTint // Text color
    tabBar.barTintColor = Colors.primaryBackground
  }

  // MARK: - TabBarCoordinator

  override func prepareTransition(for route: AppRoute) -> TabBarTransition {
    switch route {
    case .people:
      return .select(peopleRouter)
    }
  }
}

func createTabBarItem(tabBarSystemItem: UITabBarItem.SystemItem, tag: Int) -> UITabBarItem {
  let tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tag)
  tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
  tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .selected)
  tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
  return tabBarItem
}
