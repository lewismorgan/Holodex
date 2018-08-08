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
      var disposables = [Disposable]()
      
      // Create the initial fetch request
      self.networkService.fetchJson("people/?page=1") { (result: Result<PageResponse<Person>>) in
        var people = [Person]()
        switch result {
        case .success(let value):
          if let resultPeople = value.results {
            people.append(contentsOf: resultPeople)
          }

          if let next = value.next {
            // There is another page. Create the next fetch request.
            let nextPage = String(next[rootPage.endIndex...])
            // TODO: Fix nextPage string
            disposables.append(self.fetchPeople(page: 5).subscribe({ (fetchedPeople) in
              switch fetchedPeople {
              case .success(let emittedElement):
                observer.onNext(emittedElement)
              case .error(let error):
                observer.onError(error)
              }
            }))
            debugPrint("Next: \(nextPage)")
          }
        case .failure(let error):
          observer.onError(error)
        }
        observer.onNext(people)
      }
      return Disposables.create {
        for disposable in disposables {
          disposable.dispose()
        }
      }
    }
    //fatalError("not implemented yet")
  }
}
