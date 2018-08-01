//
//  PeopleAPIService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

// Disucssion on Network/Async calls https://github.com/ReSwift/ReSwift/issues/214
// and https://github.com/timojaask/ReSwiftAsyncMiddlewarePattern

import Alamofire
import Promises
import Foundation

/// Describes a PeopleService
protocol PeopleService {
  func fetchPeople(page: Int) -> Promise<[Person]>
  func fetchAllPeople() -> Promise<[Person]>
}

/// A PeopleService that is connected to a network
class NetworkPeopleService: PeopleService {
  let networkService: NetworkService

  init(_ networkService: NetworkService) {
    self.networkService = networkService
  }

  func fetchPeople(page: Int) -> Promise<[Person]> {
    let pageVal = (page >= 1 ? page : 1)
    return networkService.fetchResponseJson("people/?page=\(pageVal)")
      .then(on: DispatchQueue.global(qos: .background)) { result in
        debugPrint(result)

        var jyn = Person()
        jyn.name = "Jyn Erso"
        var anakin = Person()
        anakin.name = "Anakin Skywalker"
        return Promise([anakin, jyn])
      }
  }

  // TODO: Implement fetchAllPeople()
  func fetchAllPeople() -> Promise<[Person]> {
    // Read value of count and next
    // While the value of count != the current page, get the next page and merge w/ promise
    fatalError("fetchAllPeople() is not implemented yet")
  }
}
