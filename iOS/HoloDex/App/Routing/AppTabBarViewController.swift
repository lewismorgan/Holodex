//
//  AppTabBarViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/23/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import ReSwift

class AppTabBarViewController: UITabBarController {
  fileprivate let store: Store<AppState>

  public var peopleNavController: PeopleNavigationController<AppState>

  init(_ store: Store<AppState>) {
    self.store = store
    peopleNavController = PeopleNavigationController(store: store)
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBarItems()
  }

  func setupTabBarItems() {
    // swiftlint:disable todo

    // TODO: Create a PeopleTabBarItem
    peopleNavController.tabBarItem = UITabBarItem(title: "People", image: nil, tag: 0)

    let tabBarList = [peopleNavController]
    viewControllers = tabBarList
    // swiftlint:enable todo
  }
}
