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

  func fetchAllPeople() -> Promise<[Person]> {
    // Read value of count and next
    // While the value of count != the current page, get the next page and merge w/ promise
    return networkService.fetchPaginatedJson("people/")
      .then(on: DispatchQueue.global(qos: .background)) { (result: PageResponse<Person>) in
        return Promise { fullfill, reject in
          if let people = result.results {
            fullfill(people)
          } else {
            reject(NSError(domain: "", code: 1, userInfo: nil))
          }
        }
    }
  }
}
