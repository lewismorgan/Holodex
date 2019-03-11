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
  @IBOutlet weak private var arrow: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.selectedBackgroundView = {
      let view = UIView()
      view.backgroundColor = .tint
      return view
    }()

    self.backgroundColor = .clear
    self.tintColor = .tint
    self.name.textColor = .white
    self.arrow.textColor = .white
  }

  public func setup(name: String) {
    self.name.text = name
  }
}
