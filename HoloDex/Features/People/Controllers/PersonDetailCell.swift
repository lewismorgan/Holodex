//
//  PersonDetailCell.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/23/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import UIKit

class PersonDetailCell: UITableViewCell {

  // MARK: - Init

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.view.backgroundColor = .background
    self.view.tintColor = .tint
    self.textLabel?.textColor = .white
    self.selectionStyle = .none
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Functions

  func setup(glyph: Glyph, text: String) {
    self.textLabel?.text = text
    self.imageView?.image = UIImage.glyph(from: glyph, color: .white, size: CGSize(width: 46, height: 46))
  }
}
