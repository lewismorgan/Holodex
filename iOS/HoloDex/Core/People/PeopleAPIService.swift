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
import RxSwift

// "people/?page=\(pageVal)"

/// A PeopleService that is connected to a network
class NetworkPeopleService: PeopleService {
  let networkService: NetworkService

  init(_ networkService: NetworkService) {
    self.networkService = networkService
  }

  func fetchPeople(page: Int) -> Single<[Person]> {
    let pageVal = (page >= 1 ? page : 1)
    return self.networkService.fetchResponseJson("people/?page=\(pageVal)").map { (item: PageResponse<Person>) in
      if let people = item.results {
        return people
      } else {
        throw(GeneralHoloDexError(title: "fetchPeople", description: "error fetching people by page", code: page))
      }
    }
  }

  func fetchAllPeople() -> Observable<[Person]> {
    // TODO: create fetch people's until there is no more count lefts.
    fatalError("not implemented yet")
  }
}
