//
//  PeopleView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import Tempura

class PeopleView: HDFlexView, ViewControllerModellableView {
  var searchField: UITextField = UITextField()
  var scrollView: UIView = UIView()

  func setup() {
  }

  func style() {
    searchField.backgroundColor = .yellow
    scrollView.backgroundColor = .blue
  }

  func update(oldModel: PeopleViewModel?) {
    guard let model = self.model else { return }
    // TODO: Update UI collection of people to model.people
  }

  override func layoutFlexContent(_ flexContainer: UIView) {
    flexContainer.flex.define { (flex) in
      flex.addItem().direction(.row).margin(10).define { (flex) in
        flex.addItem(searchField).grow(1)
      }
      flex.addItem(scrollView).grow(1)
    }
  }
}
