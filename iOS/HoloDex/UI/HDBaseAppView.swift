//
//  HDBaseAppView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import ReSwift

class HDBaseAppView: HDFlexView, BaseAppView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not bee implemented")
  }

  func setup() {
  }

  func style() {
  }

  override func layoutSubviews() {
    rootFlexContainer.pin.all(self.safeAreaInsets)
    // Layout all the children
    rootFlexContainer.flex.layout()
  }
}
