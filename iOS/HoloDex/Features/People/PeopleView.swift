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

class PeopleView: UIView, FlexView, BaseAppView {
  var searchField: UITextField = UITextField()
  var scrollView: UIView = UIView()
  var root = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) not implemented")
  }

  func setup() {
    layoutFlexContent(root)
    addSubview(root)
  }

  func style() {
  }

  func layoutFlexContent(_ flexContainer: UIView) {
    searchField.backgroundColor = .white
    scrollView.backgroundColor = .blue

    flexContainer.flex.define { (flex) in
      flex.addItem().direction(.row).margin(10).define { (flex) in
        flex.addItem(searchField).grow(1)
      }
      flex.addItem(scrollView).grow(1)
    }
  }

  override func layoutSubviews() {
    root.pin.all(self.safeAreaInsets)
    root.flex.layout()
  }
}
