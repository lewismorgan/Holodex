//
//  FlexView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit

/// A view that lays out flex content using a container
protocol FlexView {
  /// Lays out components for the container
  func layoutFlexContent(_ flexContainer: UIView)
  func layoutSubviews()
}
