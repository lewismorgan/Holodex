//
//  RootRoutable.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift
import ReSwiftRouter

class RootAppRoutable: Routable {
  let store: Store<AppState>
  let window: UIWindow

  init(store: Store<AppState>, window: UIWindow) {
    self.store = store
    self.window = window
  }

  func setToAppTabBarViewController() -> Routable {
    self.window.rootViewController = AppTabBarViewController(store)

    return AppTabBarViewControllerRoutable(window.rootViewController!)
  }

  func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier,
                          animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    if to == AppRoutes.entryPoint.rawValue {
      completionHandler()
      return setToAppTabBarViewController()
    } else {
      fatalError("Route is not supported from \(from) to \(to)")
    }
  }

  func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool,
                        completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    if routeElementIdentifier == AppRoutes.entryPoint.rawValue {
      completionHandler()
      return setToAppTabBarViewController()
    } else {
      fatalError("Route is not supported at root to \(routeElementIdentifier)")
    }
  }
}
