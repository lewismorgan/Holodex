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

class PersonListViewController: UIViewController, ViewModelBinding {
  private static let nibName = "PersonListView"
  var viewModel: PersonListViewModel!

  // MARK: Private

  private let bag = DisposeBag()

  // MARK: Views

  @IBOutlet weak private var tableView: UITableView!
  @IBOutlet weak private var searchBar: UISearchBar!

  // MARK: Init

  init() {
    super.init(nibName: PersonListViewController.nibName, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  // MARK: - Functions

  private func addViewModelBindings() {
    // Search -- debounce isn't needed as there are no network requests are only made on the page
    searchBar.rx.text.orEmpty
      .distinctUntilChanged()
      .asDriver(onErrorJustReturn: "")
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

  private func createSearchBarEvents() {
    // Stop editing if the search button is clicked or the cancel button is clicked
    Observable.merge(searchBar.rx.searchButtonClicked.asObservable(), searchBar.rx.cancelButtonClicked.asObservable())
      .subscribe(onNext: { [weak self] in
        self?.searchBar.endEditing(true)
      }).disposed(by: bag)

    // Display the cancel button only when the user is searching for something (ie: keyboard displayed)

    searchBar.rx.textDidBeginEditing.asObservable().subscribe(onNext: { [weak self] _ in
      self?.searchBar.setShowsCancelButton(true, animated: true)
    }).disposed(by: bag)

    searchBar.rx.textDidEndEditing.asObservable().subscribe(onNext: { [weak self] _ in
      self?.searchBar.setShowsCancelButton(false, animated: true)
    }).disposed(by: bag)
  }

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    // Initialize variables
    // swiftlint:disable explicit_init
    tableView.register(UINib.init(nibName: "PersonCellView", bundle: nil), forCellReuseIdentifier: "PersonCell")
    // swiftlint:enable explicit_init

    // Setup the bindings to the view model
    addViewModelBindings()

    // Setup UI events
    createSearchBarEvents()

    // didSelectRowAtIndexPath alternative giving access to the model selected
    tableView.rx.modelSelected(Person.self).subscribe(onNext: { [weak self] person in
      // Deselect the row
      if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
        self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
      }

      // Call the onSelected function in the viewModel
      self?.viewModel.onSelected(person: person)

      // Display the navigation bar if this is contained in a nav controller
      if let navigationController = self?.navigationController {
        if navigationController.isNavigationBarHidden {
          navigationController.setNavigationBarHidden(false, animated: true)
        }
      }
    }).disposed(by: bag)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // Hide the top navigation bar
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
}
