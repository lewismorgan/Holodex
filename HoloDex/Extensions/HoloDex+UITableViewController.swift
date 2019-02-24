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
}
