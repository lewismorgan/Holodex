//
//  PeopleFlowController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 3/28/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

class PeopleFlowController: UIViewController {
  private let navigation = UINavigationController()
  var model: PersonListViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()

    guard (model != nil) else {
      fatalError("There is no view model set for the flow controller!")
    }

    let viewController = PersonListViewController()
    viewController.viewModel = model
    navigation.show(viewController, sender: self)
    add(navigation)
  }
}
