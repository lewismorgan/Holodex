//
//  AppTabBarRoutable.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift
import ReSwiftRouter

class AppTabBarViewControllerRoutable: ViewControllerRoutable<UITabBarController> {
  let store: Store<AppState>
  init(store: Store<AppState>, viewController: UITabBarController) {
    self.store = store
    super.init(viewController)
  }

  override func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool,
                                 completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    debugPrint("id: \(routeElementIdentifier)")
    if routeElementIdentifier == AppRoutes.people.rawValue {
      viewController.selectedIndex = 0
      completionHandler()
      guard let selected = viewController.selectedViewController else {
        fatalError()
      }
      debugPrint(selected)
      return PeopleNavigationRoutable(store: store, viewController: selected as! UINavigationController)
    } else {
      fatalError("Unknown push segment: [\(routeElementIdentifier)]")
    }
  }

  override func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier,
                                   animated: Bool,
                                   completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    // People
    // Species
    // Vehicles
    // Films
    fatalError("Change route segment")
  }
}

class PeopleNavigationRoutable: ViewControllerRoutable<UINavigationController> {
  let personDetailController: PersonDetailViewController<AppState>
  let store: Store<AppState>
  init(store: Store<AppState>, viewController: UINavigationController) {
    self.store = store
    self.personDetailController = PersonDetailViewController<AppState>(store: store)
    super.init(viewController)
  }

  override func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool,
                                 completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    viewController.pushViewController(personDetailController, animated: true)
    completionHandler()
    return PersonDetailRoutable(personDetailController)
  }

  override func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
    viewController.popViewController(animated: true)
    completionHandler()
  }
}

class PersonDetailRoutable: ViewControllerRoutable<UIViewController> {
  override func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    debugPrint("Change")
    fatalError()
  }
  override func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
    debugPrint("PersonDetail pop")
  }
}
