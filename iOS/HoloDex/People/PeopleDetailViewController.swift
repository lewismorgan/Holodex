//
//  PeopleDetailViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/11/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Core
import People
import UIKit

// TODO: - Person Bindings

class PersonDetailViewController: UIViewController {
  // MARK: - Initialization
  init(person: Person) {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  func initViewItem(viewItem: PersonDetailView) {
    view = viewItem
  }

  override func loadView() {
    initViewItem(viewItem: PersonDetailView(person: Person()))
  }

  // MARK: - View Controller Overrides
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}
