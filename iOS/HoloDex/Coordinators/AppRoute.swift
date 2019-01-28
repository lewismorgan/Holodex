//
//  AppRoute.swift
//  HoloDex
//
//  Created by Lewis Morgan on 1/25/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import XCoordinator
import People

enum AppRoute: Route {
  case home
  case people
  case person(Person)
}
