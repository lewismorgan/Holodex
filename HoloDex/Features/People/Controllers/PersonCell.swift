//
//  PersonCellController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/18/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
  @IBOutlet weak private var name: UILabel!

  public func setup(name: String) {
    self.name.text = name
  }
}
