//
//  PeopleDetailViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/11/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Core
import People
import UIKit
import ReSwift

class PersonDetailViewController<StoredAppState: PeopleStateStore & StateType>: UIViewController, AppViewController {
  let store: Store<StoredAppState>
  var mainView: PersonDetailView {
    return self.view as! PersonDetailView
  }

  // MARK: - Initialization
  init(store: Store<StoredAppState>) {
    self.store = store
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) is not implemented")
  }

  func initViewItem(viewItem: PersonDetailView) {
    view = viewItem
  }

  override func loadView() {
    var person = Person()
    person.name = "NULL"
    initViewItem(viewItem: PersonDetailView(person: person))
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
extension PersonDetailViewController: StoreSubscriber {
  func newState(state: PeopleState) {
    if let selected = state.viewingPerson {
      mainView.updatePerson(person: selected)
    }
  }
}
