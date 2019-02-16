//
//  PersonDetailViewModel.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/16/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import RxSwift
import People

protocol PersonDetailViewModel {
  var person: Variable<Person> { get }
}
