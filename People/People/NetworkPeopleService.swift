//
//  PeopleAPIService.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

// Disucssion on Network/Async calls https://github.com/ReSwift/ReSwift/issues/214
// and https://github.com/timojaask/ReSwiftAsyncMiddlewarePattern

import Network
import Alamofire
import RxSwift

/// A PeopleService that is connected to a network
public class NetworkPeopleService: PeopleService {

  let networkService: NetworkService

  public init(_ networkService: NetworkService) {
    self.networkService = networkService
  }

  /// Fetches people at the specified page along with the next page.
  public func fetchPeople(page: Int) -> Single<([Person], Int?)> {
    let pageVal = (page >= 1 ? page : 1)
    return self.networkService.fetchResponseJson("people/?page=\(pageVal)").map { (item: PageResponse<Person>) in
      if let people = item.results {
        // TODO: Convert item.next to an Int from String
        return (people, nil)
      } else {
        throw(GeneralHoloDexError(title: "fetchPeople", description: "error fetching people by page", code: page))
      }
    }
  }

  /// Fetches a person with the provided ID.
  public func fetchPerson(id: Int) -> Single<Person> {
    return self.networkService.fetchResponseJson("people/" + String(id))
  }

  /// Fetches people from the starting page to the ending page.
  public func fetchMultiplePeople(startPage: Int, endPage: Int) -> Observable<[Person]> {
    var requests = [Observable<[Person]>]()

    for page in startPage...endPage {
      requests.append(fetchPeople(page: page).map { $0.0 }.asObservable())
    }

    return Observable.merge(requests)
  }
}
