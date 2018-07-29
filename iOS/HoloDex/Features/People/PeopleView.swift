//
//  PeopleView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout
import ListKit

class PeopleView: UIView, FlexView, BaseAppView {
  var searchField: UITextField = UITextField()
  var tableView: UITableView
  var root = UIView()

  init(peopleTable: UITableView) {
    self.tableView = peopleTable
    super.init(frame: CGRect.zero)
    setup()
    style()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) not implemented")
  }

  func setup() {
    layoutFlexContent(root)
    addSubview(root)
  }

  func style() {
    searchField.backgroundColor = .white
    tableView.backgroundColor = .white
  }

  func layoutFlexContent(_ flexContainer: UIView) {
    flexContainer.flex.define { (flex) in
      flex.addItem().direction(.row).margin(10).define { (flex) in
        flex.addItem(searchField).grow(1)
      }
      flex.addItem(tableView).grow(1)
    }
  }

  override func layoutSubviews() {
    root.pin.all(self.safeAreaInsets)
    root.flex.layout()
  }
}
