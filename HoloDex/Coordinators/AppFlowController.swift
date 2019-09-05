//
//  AppFlowController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 3/28/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

class AppFlowController: UIViewController {
  private let tabController = UITabBarController()

  override func viewDidLoad() {
    super.viewDidLoad()
    tabController.viewControllers = []
    addChild(tabController)
  }
}
