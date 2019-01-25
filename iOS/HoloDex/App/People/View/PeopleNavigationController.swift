//
//  PeopleNavigationViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/10/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Core
import People
import UIKit

/// Manages switching between the list of people and the detailed view
class PeopleNavigationController: UINavigationController, UINavigationControllerDelegate, PeopleViewControllerDelegate {
  private var priorViewController: UIViewController?
  private var didShowDetailController: Bool = false

  // MARK: - Initialization
  init() {
    super.init(nibName: nil, bundle: nil)
    loadViewControllers()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented.")
  }

  func loadViewControllers() {
    let peopleViewController = PeopleViewController()
    peopleViewController.delegate = self

    let controllers = [peopleViewController]
    viewControllers = controllers
    delegate = self
  }

  // MARK: - UINavigationControllerDelegate

  func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController, animated: Bool) {
    // TODO - Routing from navigation controller back button
  }

  func onPersonSelected(selected person: Person) {
    // TODO: - Push view controller
  }
}
