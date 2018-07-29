//
//  PeopleTableViewCell.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import ListKit

class PersonTableViewCell: UITableViewCell, ListKitCellProtocol {
  var model: Person? {
    didSet {
      self.textLabel!.text = model?.name ?? ""
    }
  }
}