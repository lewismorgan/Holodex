//
//  HDFlexibleView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout

/// A view that can easily use flex
class HDFlexView: UIView, FlexView {
  internal let rootFlexContainer = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    layoutFlexContent(rootFlexContainer)
    addSubview(rootFlexContainer)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func layoutFlexContent(_ flexContainer: UIView) {
    fatalError("layoutFlexContent(flexContainer:) has not been implemented")
  }

  override func layoutSubviews() {
    // Sizes the subviews but we're using Yoga/Flex so it's not needed.
    // super.layoutSubviews()
    // Pin the flex container to the parent views size
    rootFlexContainer.pin.all(self.safeAreaInsets)
    // Layout all the children
    rootFlexContainer.flex.layout()
  }
}
