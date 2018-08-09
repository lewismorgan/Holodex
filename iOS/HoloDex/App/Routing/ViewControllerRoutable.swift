//
//  RoutableByViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import ReSwiftRouter

/// Base class for a routable that contains a view controller
class ViewControllerRoutable: Routable {
  let viewController: UIViewController

  init(_ viewController: UIViewController) {
    self.viewController = viewController
  }

  /// Switches from one route element to another
  func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier,
                          animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    fatalError("Route change is not implemented")
  }

  /// Pushes a base route
  func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool,
                        completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    fatalError("Route push is not implemented")
  }

  /// Pops a route element from the route segment
  func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool,
                       completionHandler: @escaping RoutingCompletionHandler) {
    fatalError("Route pop is not implemented")
  }

  func getIdentifier() -> RouteElementIdentifier {
    fatalError("No identifier is specified for this view controller routable")
  }
}
