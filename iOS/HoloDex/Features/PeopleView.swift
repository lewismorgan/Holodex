//
//  PeopleView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit

class PeopleView: HDBaseAppView {
  var searchField: UITextField = UITextField()
  var scrollView: UIView = UIView()

  override func layoutFlexContent(_ flexContainer: UIView) {
    searchField.backgroundColor = .white
    scrollView.backgroundColor = .blue

    flexContainer.flex.define { (flex) in
      flex.addItem().direction(.row).margin(10).define { (flex) in
        flex.addItem(searchField).grow(1)
      }
      flex.addItem(scrollView).grow(1)
    }
  }
}
