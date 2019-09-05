//
//  HoloDex+UITableViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/22/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

extension UITableViewController {
  func addSearchController(placeholder: String, searchResultsUpdater: UISearchResultsUpdating) {
    let searchController = UISearchController(searchResultsController: nil)

    searchController.searchResultsUpdater = searchResultsUpdater
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = placeholder
    searchController.searchBar.tintColor = .tint
    searchController.searchBar.barTintColor = .tint
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }

  func setupNavigationBar(title: String? = nil) {
    if let navController = self.navigationController {
      if let navTitle = title {
        navigationItem.title = navTitle
      }
      navController.navigationBar.prefersLargeTitles = true
      navController.navigationBar.barStyle = .black
      //navController.navigationBar.view.backgroundColor = .black
      navController.navigationBar.tintColor = .tint
    }
  }
}
