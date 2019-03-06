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

class PersonListViewController: UITableViewController, ViewModelBinding {
  var viewModel: PersonListViewModel?

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

    // TODO: Set placeholder to a random person in the list of names
    // TODO: Assisted search by suggesting a name to search for when user starts to type
    addSearchController(placeholder: "Luke Skywalker", searchResultsUpdater: self)

    // Deselect the row when selected and perform viewmodel actions
    tableView.rx.modelSelected(Person.self).subscribe(onNext: { [weak self] person in
      if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
        self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
      }

      self?.onPersonSelected(person: person)
    }).disposed(by: bag)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.view.backgroundColor = .black
    self.tableView.backgroundColor = .black

    setupNavigationBar()

    // display the search bar
    navigationItem.hidesSearchBarWhenScrolling = false

    if let model = viewModel {
      // TODO: There is probably a better way of doing this than setting the value?
      model.request.value = true
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Search bar is already shown, so now hide it when user scrolls
    navigationItem.hidesSearchBarWhenScrolling = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }

  // MARK: - ViewModelBinding

  func modelWasBound(model: PersonListViewModel) {
    queryPublisher.asDriver(onErrorJustReturn: "")
      .drive(model.query)
      .disposed(by: bag)

    // TODO: Display an Activity Indicator when loading is emitted from model
    model.loading.asObservable().debug("📶").subscribe().disposed(by: bag)

    // Set the table items to the filter list in the model
    model.filtered
      .bind(to: tableView.rx.items(cellIdentifier: "PersonCell")) { _, model, cell in
        guard let personCell = cell as? PersonCell else {
          return
        }
        personCell.setup(name: model.name ?? "")
      }
      .disposed(by: bag)
  }

  func modelWasUnbound(model: PersonListViewModel) {
  }

  // MARK: - Functions

  private func onPersonSelected(person: Person) {
    if let model = viewModel {
      model.onSelected(person: person)
    }
  }
}

extension PersonListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let query = searchController.searchBar.text else {
      return
    }
    queryPublisher.onNext(query)
  }
}
