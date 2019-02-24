//
//  PersonListViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import People
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class PersonListViewController: UITableViewController, UISearchResultsUpdating, ViewModelBinding {
  private static let nibName = "PersonList"
  var viewModel: PersonListViewModel!

  // MARK: Private

  private let queryPublisher = PublishSubject<String>()
  private let bag = DisposeBag()

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    // Initialize variables
    // swiftlint:disable explicit_init
    tableView.register(UINib.init(nibName: "PersonCellView", bundle: nil), forCellReuseIdentifier: "PersonCell")
    // swiftlint:enable explicit_init

    // TODO: Assisted search by suggesting a name to search for when user starts to type
    addSearchController(placeholder: "Luke Skywalker", searchResultsUpdater: self)

    // Setup the bindings to the view model
    addViewModelBindings()

    // Deselect the row when selected and perform viewmodel actions
    tableView.rx.modelSelected(Person.self).subscribe(onNext: { [weak self] person in
      if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
        self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
      }

      self?.viewModel.onSelected(person: person)

    }).disposed(by: bag)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.view.backgroundColor = .black
    self.tableView.backgroundColor = .black

    setupNavigationBar()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  // MARK: - UISearchResultsUpdating
  func updateSearchResults(for searchController: UISearchController) {
    guard let query = searchController.searchBar.text else {
      return
    }
    queryPublisher.onNext(query)
  }

  // MARK: - Functions

  private func addViewModelBindings() {
    queryPublisher.asDriver(onErrorJustReturn: "")
      .drive(viewModel.query)
      .disposed(by: bag)

    // Activity Indicator
    viewModel.loading.asObservable().debug("❤️").subscribe().disposed(by: bag)
    // List of People bound to the filtered list, filtering handled by the ViewModel implementation
    viewModel.filtered
      .bind(to: tableView.rx.items(cellIdentifier: "PersonCell")) { _, model, cell in
        guard let personCell = cell as? PersonCell else {
          return
        }
        personCell.setup(name: model.name ?? "")
      }
      .disposed(by: bag)
  }
}
