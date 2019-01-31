//
//  PeopleViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Network
import People
import UIKit

protocol PeopleViewControllerDelegate: AnyObject {
  func onPersonSelected(selected person: Person)
}

class PeopleViewController: UIViewController {
  weak var delegate: PeopleViewControllerDelegate?

  // MARK: - Initialization
  init() {
    super.init(nibName: nil, bundle: nil)
    tabBarItem = UITabBarItem(title: "People", image: nil, tag: 0)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  func initViewItem(viewItem: PeopleView) {
    view = viewItem
  }

  override func loadView() {
    initViewItem(viewItem: PeopleView(people: [Person]()) { selected in
      self.delegate?.onPersonSelected(selected: selected)
    })
  }

  // MARK: - View Controller Overrides
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}
