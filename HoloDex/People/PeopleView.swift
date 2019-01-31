//
//  PeopleView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Network
import People
import UIKit
import PinLayout
import FlexLayout

class PeopleView: UIView {
  var tableView: UITableView = UITableView()
  var root = UIView()
  var peopleTableData: [Person]
  var onSelectPersonDelegate: ((Person) -> Void)?

  init(people: [Person], onSelectPersonDelegate: @escaping (Person) -> Void) {
    self.peopleTableData = people
    self.onSelectPersonDelegate = onSelectPersonDelegate
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

  func appendTableData(people: [Person]) {
    self.peopleTableData.append(contentsOf: people)
  }
}

extension PeopleView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let person = peopleTableData[indexPath.row]
    onSelectPersonDelegate?(person)
    print("Selected item at row: " + String(indexPath.row))
  }

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
    return UITableView.automaticDimension
  }
}
