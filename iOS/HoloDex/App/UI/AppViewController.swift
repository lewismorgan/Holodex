//
//  HDViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/26/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift

protocol AppViewController {
  associatedtype ViewItem
  var mainView: ViewItem { get }
  func initViewItem(viewItem: ViewItem)
  func loadView()
}
