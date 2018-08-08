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

  /// Fetchs all the people
  func fetchAllPeople() -> Observable<[Person]> {
    // Create the initial page request
    // Inside page requests completionHandler: get the next page that should be requested to
    // Rinse & Repeat ^^^^^^^^^^^^
    return Observable<[Person]>.create { observer in
      let rootPage = "https://swapi.co/api/people/"
      var nextPage = "people/?page="
      var expectedSize = 20

      var requestCount = 2
      while requestCount <= 2 {
        self.networkService.fetchJson(nextPage + String(requestCount)) { (result: Result<PageResponse<Person>>) in
          var people = [Person]()
          switch result {
          case .success(let value):
            if let resultPeople = value.results {
              people.append(contentsOf: resultPeople)
            }
            if let count = value.count {
              if count != expectedSize {
                expectedSize = count
              }
            }
            if let next = value.next {
              nextPage = String(next[rootPage.endIndex...])
              // TODO: From the nextPage, create another request
              debugPrint("Next: \(nextPage)")
            }
          case .failure(let error):
            observer.onError(error)
          }
          // TODO: Remove after this
          var hax = 0
          while hax <= 30 {
            hax += 1
          }
          // TODO: Remove before this
          observer.onNext(people)
        }
        requestCount += 1
      }
      return Disposables.create {}
    }
    //fatalError("not implemented yet")
  }
}
