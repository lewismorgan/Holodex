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
  @IBOutlet weak public var searchBar: UISearchBar!

  // MARK: Init

  init() {
    super.init(nibName: PersonListViewController.NIB_NAME, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  // MARK: - Functions

  private func addViewModelBindings() {
    // Search -- debounce isn't needed as there are no network requests are only made on the page
    searchBar.rx.text.orEmpty
      .distinctUntilChanged()
      .debug("🔎", trimOutput: false)
      .asDriver(onErrorJustReturn: "")
      .drive(viewModel.query)
      .disposed(by: bag)

    // List of People bound to the filtered list, filtering handled by the ViewModel implementation
    viewModel.filtered.debug("😅", trimOutput: true)
      .bind(to: tableView.rx.items(cellIdentifier: "PersonCell")) { _, model, cell in
        cell.textLabel?.text = model.name
      }
      .disposed(by: bag)
  }

  // MARK: - UIViewController

  override func viewDidLoad() {
    // Initialize variables
    tableView.register(PersonCell.self, forCellReuseIdentifier: "PersonCell")

    // Setup the bindings to the view model
    addViewModelBindings()

    // Add event handlers

    // Same thing as didSelectRowAtIndexPath, just provides a direct access to the model
    tableView.rx.modelSelected(Person.self).subscribe(onNext: { [weak self] person in
      // Deselect the row
      if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
        self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
      }

      // Call the onSelected function in the viewModel
      self?.viewModel.onSelected(person: person)
    }).disposed(by: bag)
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
