//
//  UIViewController+ViewModelBinding.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/8/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

extension ViewModelBinding where Self: UIViewController {
  func bind(to model: Self.ViewModelType) {
    viewModel = model
    createBinding()
  }
}
