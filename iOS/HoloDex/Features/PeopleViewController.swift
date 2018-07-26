//
//  PeopleViewController.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import UIKit
import Katana
import Tempura

class PeopleViewController: ViewControllerWithLocalState<PeopleView> {

}

struct PeopleLocalState: LocalState {
  var people: [Person]?
}
