//
//  PersonListViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import People
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PersonListViewController: UIViewController, ViewModelBinding {
  private static let NIB_NAME = "PersonListView"
  var viewModel: PersonListViewModel!

  // MARK: - Private

  private let bag = DisposeBag()

  // MARK: - Views

  @IBOutlet weak public var tableView: UITableView!

  // MARK: - Initialization

  init() {
    super.init(nibName: PersonListViewController.NIB_NAME, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  // MARK: - ViewModelBinding

  func createBinding() {
    viewModel.people.bind(to: tableView.rx.items(cellIdentifier: "PersonCell")) { _, model, cell in
      cell.textLabel?.text = model.name
    }.disposed(by: bag)
  }

  // MARK: - View Controller Overrides

  override func viewDidLoad() {
    tableView.register(PersonCell.self, forCellReuseIdentifier: "PersonCell")
    createBinding()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

class PersonCell: UITableViewCell {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
