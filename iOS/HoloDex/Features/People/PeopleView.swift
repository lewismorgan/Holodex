//
//  PeopleView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout

class PeopleView: UIView, FlexView, BaseAppView {
  var tableView: UITableView = UITableView()
  var root = UIView()
  var peopleTableData: [Person]

  init(people: [Person]) {
    self.peopleTableData = people
    super.init(frame: CGRect.zero)
    setup()
    style()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) not implemented")
  }

  func setup() {
    tableView.estimatedRowHeight = 10
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.reuseIdentifier)
    layoutFlexContent(root)
    addSubview(root)
  }

  func style() {
    tableView.backgroundColor = .white
  }

  func layoutFlexContent(_ flexContainer: UIView) {
    flexContainer.flex.define { (flex) in
      flex.addItem(tableView).grow(1)
    }
  }

  override func layoutSubviews() {
    root.pin.all(self.safeAreaInsets)
    root.flex.layout()
  }

  func configureTableData(people: [Person]) {
    self.peopleTableData = people
    tableView.reloadData()
  }
}

extension PeopleView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return peopleTableData.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier,
                                             for: indexPath) as! PersonTableViewCell
    cell.configure(person: peopleTableData[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // The UITableView will call the cell's sizeThatFit() method to compute the height.
    // WANRING: You must also set the UITableView.estimatedRowHeight for this to work.
    return UITableViewAutomaticDimension
  }
}
