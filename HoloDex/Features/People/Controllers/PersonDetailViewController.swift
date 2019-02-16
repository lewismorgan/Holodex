//
//  PersonDetailViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/16/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit
import People
import RxSwift
import RxCocoa

class PersonDetailViewController: UIViewController, ViewModelBinding {
  private static let NIB_NAME = "PersonDetailView"
  var viewModel: PersonDetailViewModel!

  // MARK: - Views
  @IBOutlet weak public var nameLabel: UILabel!

  // MARK: - Init

  init() {
    super.init(nibName: PersonDetailViewController.NIB_NAME, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

}
