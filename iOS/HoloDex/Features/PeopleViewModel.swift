//
//  PeopleViewModel.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Katana
import Tempura

struct PeopleViewModel: ViewModelWithLocalState {
  var people: [Person]?

  init?(state: AppState?, localState: PeopleLocalState) {
    guard state != nil else { return nil }
    self.people = localState.people
  }
}
