//
//  StarWarsAPI.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import Promises

protocol NetworkService {
  func fetchResponseJson(_ url: String) -> Promise<Any>
  func fetchPaginatedJson<T: Mappable & Codable>(_ url: String) -> Promise<PageResponse<T>>
}

struct PageResponse<T: Mappable & Codable>: Mappable, Codable {
  var count: Int?
  var next: String?
  var previous: String?
  var results: [T]?

  init?(map: Map) {
  }
  mutating func mapping(map: Map) {
    count <- map["count"]
    next <- map["next"]
    previous <- map["previous"]
    results <- map["results"]
  }
}

class StarWarsAPI: NetworkService {
  let baseUrl = "https://swapi.co/api/"

  func fetchPaginatedJson<T: Mappable & Codable>(_ url: String) -> Promise<PageResponse<T>> {
    return Promise { fullfill, reject in
      Alamofire.request(self.baseUrl + url).responseObject { (response: DataResponse<PageResponse<T>>) in
        switch response.result {
        case .success(let value):
          fullfill(value)
        case.failure(let error):
          reject(error)
        }
      }
    }
  }

  func fetchResponseJson(_ url: String) -> Promise<Any> {
    return Promise { fullfill, reject in
      debugPrint("Request: \(self.baseUrl)\(url)")
      Alamofire.request(self.baseUrl + url).responseJSON { response in
        switch response.result {
        case .success(let value):
          fullfill(value)
        case .failure(let error):
          reject(error)
        }
      }
    }
  }
}
