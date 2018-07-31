//
//  StarWarsAPI.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Promises

protocol NetworkService {
  func fetchResponseJson(_ url: String) -> Promise<Any>
}

class StarWarsAPI: NetworkService {
  func fetchResponseJson(_ url: String) -> Promise<Any> {
    return Promise("nil")
  }
}
