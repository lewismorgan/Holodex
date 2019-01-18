//
//  PeopleViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Core
import People
import UIKit
import ReSwift
import ReSwiftRouter

protocol PeopleViewControllerDelegate: AnyObject {
  func onPersonSelected(selected person: Person)
}

class PeopleViewController<StoredAppState: PeopleStateStore & StateType>:
        UIViewController, AppViewController {
  let store: Store<StoredAppState>
  var mainView: PeopleView {
    return self.view as! PeopleView
  }

  weak var delegate: PeopleViewControllerDelegate?

  // MARK: - Initialization
  init(store: Store<StoredAppState>) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  func initViewItem(viewItem: PeopleView) {
    view = viewItem
  }

  override func loadView() {
    initViewItem(viewItem: PeopleView(people: [Person]()) { selected in
      self.delegate?.onPersonSelected(selected: selected)
    })
  }

  // MARK: - View Controller Overrides
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    store.subscribe(self) {
      $0.select { state in state.peopleState }
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillAppear(animated)

    store.unsubscribe(self)
  }
}

// MARK: - StoreSubscriber
extension PeopleViewController: StoreSubscriber {
  func newState(state: PeopleState) {
    switch state {
    case .empty:
      mainView.configureTableData(people: [Person]())
    case .loading:
      debugPrint("PeopleState has entered the loading state")
    case .paging(let people, _):
      mainView.appendTableData(people: people)
    case .populated(let people):
      mainView.configureTableData(people: people)
    default:
      break
    }
  }
}
