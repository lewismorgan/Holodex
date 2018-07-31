//
//  PeopleAPIService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

// Disucssion on Network/Async calls https://github.com/ReSwift/ReSwift/issues/214
// and https://github.com/timojaask/ReSwiftAsyncMiddlewarePattern

import PromiseKit
import Foundation

protocol PeopleService {
  func fetchPeople() -> Promise<[Person]>
}

/// A PeopleService that is connected to a network
class NetworkPeopleService: PeopleService {
  let networkService: NetworkService

  init(_ networkService: NetworkService) {
    self.networkService = networkService
  }

  func fetchPeople() -> Promise<[Person]> {
    // TODO Create API Calls to SWAPI
    return nil
  }
  
  func convertToPersonArray() -> [Person] {
    var jyn = Person()
    jyn.name = "Jyn Arson"
    var anakin = Person()
    anakin.name = "Anakin Skywailer"
    return [jyn, anakin]
  }
}
