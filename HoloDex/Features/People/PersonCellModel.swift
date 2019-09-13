//
//  PersonCellModel.swift
//  HoloDex
//
//  Created by Lewis Morgan on 9/13/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Foundation

struct PersonCellModel: Identifiable, Hashable {
  let id = UUID()
  let name: String
}

extension PersonCellModel {
  init(for person: Person) {
    self.name = person.name
  }
}
