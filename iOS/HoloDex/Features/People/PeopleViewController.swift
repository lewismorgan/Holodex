//
//  PeopleViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import ReSwift

class PeopleViewController<StoredAppState: PeopleStateStore & StateType>:
        UIViewController, AppViewController, StoreSubscriber {
  let store: Store<StoredAppState>
  var mainView: PeopleView {
    return self.view as! PeopleView
  }

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
    initViewItem(viewItem: PeopleView())
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
  
  // MARK: - Redux
  func newState(state: PeopleState) {
    // TODO: Setting PeopleView by the PeopleState
  }
}
