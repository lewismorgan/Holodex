//
//  HoloDex+UIViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 3/28/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

extension UIViewController {
  /// Adds the view controller as a child of this view controller with a subview of the child.
  func add(_ child: UIViewController) {
    addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }
}
