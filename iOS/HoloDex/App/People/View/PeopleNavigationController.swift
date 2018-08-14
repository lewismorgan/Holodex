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
import ReSwift
import ReSwiftRouter

/// Manages switching between the list of people and the detailed view
class PeopleNavigationController<StoredAppState: PeopleStateStore & StateType>:
UINavigationController, UINavigationControllerDelegate {
  let store: Store<StoredAppState>
  private var priorViewController: UIViewController?
  private var didShowDetailController: Bool = false
  // MARK: - Initialization
  init(store: Store<StoredAppState>) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
    loadViewControllers()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented.")
  }

  func loadViewControllers() {
    let peopleViewController = PeopleViewController(store: store)
    peopleViewController.delegate = self

    let controllers = [peopleViewController]
    viewControllers = controllers
    delegate = self
  }

  func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController, animated: Bool) {
    // Router doesn't really work with UINavigationControllers, so this is a workaround to send
    // a route update when the back button is pressed.
    if viewController is PeopleViewController<StoredAppState> {
      if didShowDetailController {
        store.dispatch(SetRouteAction([AppRoutes.home.rawValue, AppRoutes.people.rawValue]))
        didShowDetailController = false
      }
    } else if viewController is PersonDetailViewController<StoredAppState> {
      didShowDetailController = true
    }
  }
}

extension PeopleNavigationController: PeopleViewControllerDelegate {
  func onPersonSelected(selected person: Person) {
    store.dispatch(PeopleActions.DetailPerson.show(person: person))
    store.dispatch(SetRouteAction([AppRoutes.home.rawValue, AppRoutes.people.rawValue,
                                   AppRoutes.peopleDetail.rawValue]))
  }
}
