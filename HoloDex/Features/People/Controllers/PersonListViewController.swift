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

  // MARK: Private

  private let bag = DisposeBag()

  // MARK: Views

  @IBOutlet weak public var tableView: UITableView!

  // MARK: Init

  init() {
    super.init(nibName: PersonListViewController.NIB_NAME, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  // MARK: - Functions

  /// Add the observable bindings from the view model to the view
  private func addBindings() {
    viewModel.people.asObservable()
      .bind(to: tableView.rx.items(cellIdentifier: "PersonCell")) { _, model, cell in
        cell.textLabel?.text = model.name
      }
      .disposed(by: bag)
  }

  // MARK: - UIViewController

  override func viewDidLoad() {
    // MARK: View Initialization
    tableView.register(PersonCell.self, forCellReuseIdentifier: "PersonCell")

    addBindings()

    // Same thing as didSelectRowAtIndexPath, just provides a direct access to the model
    tableView.rx.modelSelected(Person.self).subscribe(onNext: { [weak self] person in
      // Deselect the row
      if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
        self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
      }

      // Call the onSelected function in the viewModel
      self?.viewModel.onSelected(person: person)
    })
    .disposed(by: bag)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

// MARK: - Utility Classes

class PersonCell: UITableViewCell {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}