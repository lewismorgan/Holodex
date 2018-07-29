//
//  HDViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import ReSwift

//class HDViewController<ViewType: UIView, StoreStateType: StateType>: UIViewController {
//  internal let store: Store<StoreStateType>
//  internal var mainView: ViewType {
//    return self.view as! ViewType
//  }
//
//  init(store: Store<StoreStateType>) {
//    self.store = store
//    super.init(nibName: nil, bundle: nil)
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not bee implemented")
//  }
//
//  func initViewItem(viewItem: ViewType) {
//    view = viewItem as ViewType
//  }
//
//  override func loadView() {
//    initViewItem(viewItem: ViewType())
//  }
//}

protocol AppViewController {
  associatedtype ViewItem
  var mainView: ViewItem { get }
  func initViewItem(viewItem: ViewItem)
  func loadView()
}
