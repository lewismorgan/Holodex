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

protocol PeopleService {
  func fetchPeople() -> Promise<[Person]>
}

/// A PeopleService that is connected to a network
class NetworkPeopleService: PeopleService {
  func fetchPeople() -> Promise<[Person]> {
    let promise = Promise<[Person]> { fullfill, reject in
      Alamofire.request("https://httpbin.org/get").responseJSON { response in
        switch response.result {
        case .success(let value):
          debugPrint("Response value: \(value)")
          var jyn = Person()
          jyn.name = "Jyn Arson"
          var anakin = Person()
          anakin.name = "Anakin Skywailer"
          fullfill([jyn, anakin])
        case .failure(let error):
          reject(error)
        }
      }
    }
    return promise
  }
}
