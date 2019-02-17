//
//  PersonDetailViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/16/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import People
import RxCocoa
import RxSwift
import UIKit

class PersonDetailViewController: UIViewController, ViewModelBinding {
  private static let nibName = "PersonDetailView"
  var viewModel: PersonDetailViewModel!

  // MARK: Private
  private let bag = DisposeBag()

  // MARK: Views
  @IBOutlet weak private var name: UILabel!
  @IBOutlet weak private var birth: UILabel!
  @IBOutlet weak private var gender: UILabel!
  @IBOutlet weak private var height: UILabel!
  @IBOutlet weak private var weight: UILabel!
  @IBOutlet weak private var hair: UILabel!
  @IBOutlet weak private var eyes: UILabel!

  // MARK: Init

  init() {
    super.init(nibName: PersonDetailViewController.nibName, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    let person = viewModel.person.asDriver().debug()

    person.map { $0.name }
      .drive(name.rx.text)
      .disposed(by: bag)

    person.map { $0.birthYear }
      .map { "Born on \($0 ?? "<UNKNOWN>")" }
      .drive(birth.rx.text)
      .disposed(by: bag)

    person.map({ person -> String in
      guard let gender = person.gender else {
        return "N/A Gender"
      }
      if !(gender == "male" || gender == "female") {
        return "N/A Gender"
      }
      return gender
    })
      .map { $0.capitalized }
      .drive(gender.rx.text)
      .disposed(by: bag)

    person.map { $0.height }
      .map { "Height of \($0 ?? "<UNKNOWN>")" }
      .drive(height.rx.text)
      .disposed(by: bag)

    person.map { $0.hairColor }
      .map { "\($0?.capitalized ?? "<UNKNOWN>") Hair" }
      .drive(hair.rx.text)
      .disposed(by: bag)

    person.map { $0.eyeColor }
      .map { "\($0?.capitalized ?? "<UNKNOWN>") Eyes" }
      .drive(eyes.rx.text)
      .disposed(by: bag)

    person.map { $0.mass }
      .map { "Weighs at \($0 ?? "<UNKNOWN>")" }
      .drive(weight.rx.text)
      .disposed(by: bag)
  }
}
