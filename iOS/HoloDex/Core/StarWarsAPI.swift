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
  func fetchResponseJson<T: Mappable & Codable>(_ url: String, on queue: DispatchQueue) -> Promise<T>
}

/// Connects to the StarWarsAPI
class StarWarsAPI {
  let baseUrl = "https://swapi.co/api/"

  func createRequest<T: BaseMappable>(_ url: String,
                                      completionHandler: @escaping (Alamofire.DataResponse<T>) -> Void) -> DataRequest {
      return Alamofire.request(baseUrl + url).responseObject(completionHandler: completionHandler)
  }
}

extension StarWarsAPI: NetworkService {
  /// Creates a request to the Star Wars API and returns a promise with the expected result type
  func fetchResponseJson<T: Mappable & Codable>(_ url: String, on queue: DispatchQueue) -> Promise<T> {
    return Promise<T>(on: queue) { fullfill, reject in
      _ = self.createRequest(self.baseUrl + url) { (response: DataResponse<T>) in
        switch response.result {
        case .success(let result):
          fullfill(result)
        case .failure(let error):
          reject(error)
        }
      }
    }
  }
}
