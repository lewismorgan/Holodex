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

  // MARK: Private
  private let bag = DisposeBag()

  // MARK: Views
  @IBOutlet weak public var name: UILabel!
  @IBOutlet weak public var birth: UILabel!
  @IBOutlet weak public var gender: UILabel!
  @IBOutlet weak public var height: UILabel!
  @IBOutlet weak public var weight: UILabel!
  @IBOutlet weak public var hair: UILabel!
  @IBOutlet weak public var eyes: UILabel!

  // MARK: Init

  init() {
    super.init(nibName: PersonDetailViewController.NIB_NAME, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  // MARK: - UIViewController

  override func viewDidLoad() {
    let person = viewModel.person.asDriver().debug()

    person.map { $0.name }
      .drive(name.rx.text)
      .disposed(by: bag)

    person.map { $0.birthYear }
      .map { "Born on \($0 ?? "<UNKNOWN>")" }
      .drive(birth.rx.text)
      .disposed(by: bag)

    person.map { $0.gender }
      .drive(gender.rx.text)
      .disposed(by: bag)

    person.map { $0.height }
      .map { "Height of \($0 ?? "<UNKNOWN>")" }
      .drive(height.rx.text)
      .disposed(by: bag)

    person.map { $0.hairColor }
      .map { "\($0 ?? "<UNKNOWN>") Hair" }
      .drive(hair.rx.text)
      .disposed(by: bag)

    person.map { $0.eyeColor }
      .map { "\($0 ?? "<UNKNOWN>") Eyes" }
      .drive(eyes.rx.text)
      .disposed(by: bag)

    person.map { $0.mass }
      .map { "Weighs at \($0 ?? "<UNKNOWN>")" }
      .drive(weight.rx.text)
      .disposed(by: bag)
  }
}