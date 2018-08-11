//
//  HDBaseAppView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

protocol BaseAppView : FlexView {
  /// Initialization of components within the view
  func setup()
  /// Perform any styling for components within this method
  func style()
}
