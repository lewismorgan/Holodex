//
//  PeopleDetailView.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/11/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Foundation
import People
import UIKit

class PersonDetailView: UIView, FlexView, BaseAppView {
  var name = UILabel()
  var person: Person

  init(person: Person) {
    self.person = person
    super.init(frame: .zero)
    setup()
    style()
    layoutFlexContent(self)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("required init(coder:) not implemented")
  }

  func setup() {
  }

  func style() {
    backgroundColor = UIColor.yellow
  }

  func layoutFlexContent(_ flexContainer: UIView) {
    flexContainer.flex.define { (flex) in
      flex.addItem(name).alignContent(.center)
    }
  }

  func updatePerson(person: Person) {
    if let pName = person.name {
      name.text = pName
    }
  }
}
