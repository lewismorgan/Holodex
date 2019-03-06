//
//  ViewModelBinding.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Foundation

protocol ViewModelBinding: AnyObject {
  associatedtype ViewModelType

  var viewModel: ViewModelType? { get set }

  func modelWasBound(model: ViewModelType)
  func modelWasUnbound(model: ViewModelType)
}
