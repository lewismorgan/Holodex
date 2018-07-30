//
//  PersonCell.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell, BaseAppView, FlexView {
  static let reuseIdentifier = "PersonTableViewCellCell"
  let nameLabel = UILabel()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    self.style()
    layoutFlexContent(contentView)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func setup() {
  }

  func style() {
    selectionStyle = .none
    separatorInset = .zero
  }

  func configure(person: Person) {
    nameLabel.text = person.name
    nameLabel.flex.markDirty()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layout()
  }

  func layout() {
    contentView.flex.layout(mode: .adjustHeight)
  }

  func layoutFlexContent(_ flexContainer: UIView) {
    flexContainer.flex.padding(12).define { (flex) in
      flex.addItem(nameLabel)
    }
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    // 1) Set the contentView's width to the specified size parameter
    contentView.pin.width(size.width)

    // 2) Layout contentView flex container
    layout()

    // Return the flex container new size
    return contentView.frame.size
  }
}
