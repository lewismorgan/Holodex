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
    return networkService.fetchResponseJson("people/?page=\(pageVal)", on: DispatchQueue.global(qos: .background))
      .then(on: DispatchQueue.global(qos: .background)) { (result: PageResponse<Person>) in
        return Promise<[Person]> { fullfill, _ in
          guard let people = result.results else {
            fatalError()
          }
          fullfill(people)
        }
    }
  }

  func fetchAllPeople() -> Promise<[Person]> {
    fatalError("fetchAllPeople() is not implemented yet.")
  }
}

extension NetworkService {
  static func workThread() -> DispatchQueue {
    return DispatchQueue.global(qos: .background)
  }
}
