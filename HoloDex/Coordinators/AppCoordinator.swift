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

    let peopleCoordinator = PeopleListCoordinator(endpoint: endpoint)
    peopleCoordinator.rootViewController.tabBarItem = createTabBarItem(title: "People", from: .person, tag: 0)

    self.init(peopleRouter: peopleCoordinator.anyRouter)
  }

  init(peopleRouter: AnyRouter<PeopleListRoute>) {
    self.peopleRouter = peopleRouter

    super.init(tabs: [PlaceholderRoutes.films, PlaceholderRoutes.species, peopleRouter,
                      PlaceholderRoutes.planets, PlaceholderRoutes.vehicles], select: peopleRouter)

    setupView()
  }

  // MARK: - Private Functions
  private func setupView() {
    let tabBar = self.rootViewController.tabBar
    tabBar.barStyle = .black

    tabBar.tintColor = .tint // Text color
  }

  // MARK: - TabBarCoordinator

  override func prepareTransition(for route: AppRoute) -> TabBarTransition {
    switch route {
    case .people:
      return .select(peopleRouter)
    }
  }
}

func createTabBarItem(title: String, from: Glyph, tag: Int) -> UITabBarItem {
  let tabBarItem = UITabBarItem(title: title,
                                image: UIImage.glyph(from: from, color: .white, size: CGSize.tabBarIcon), tag: 0)
  tabBarItem.selectedImage = UIImage.glyph(from: from, color: .tint, size: CGSize.tabBarIcon)
  return tabBarItem
}

// TODO: Remove this struct when all coordinators are implementated
struct PlaceholderRoutes {
  static var vehicles: AnyRouter<PlaceholderRoute> {
    let coord = NavigationCoordinator<PlaceholderRoute>()
    coord.rootViewController.tabBarItem = createTabBarItem(title: "Vehicles", from: .starship, tag: 0)
    return coord.anyRouter
  }
  static var planets: AnyRouter<PlaceholderRoute> {
    let coord = NavigationCoordinator<PlaceholderRoute>()
    coord.rootViewController.tabBarItem = createTabBarItem(title: "Planets", from: .planet, tag: 0)
    return coord.anyRouter
  }
  static var species: AnyRouter<PlaceholderRoute> {
    let coord = NavigationCoordinator<PlaceholderRoute>()
    coord.rootViewController.tabBarItem = createTabBarItem(title: "Species", from: .dna, tag: 0)
    return coord.anyRouter
  }
  static var films: AnyRouter<PlaceholderRoute> {
    let coord = NavigationCoordinator<PlaceholderRoute>()
    coord.rootViewController.tabBarItem = createTabBarItem(title: "Films", from: .film, tag: 0)
    return coord.anyRouter
  }
}

enum PlaceholderRoute: Route {}

extension CGSize {
  static var tabBarIcon: CGSize { return CGSize(width: 34, height: 34) }
}
