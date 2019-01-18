//
//  StarWarsAPI.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import RxSwift

/// Connects to the StarWarsAPI
public class StarWarsAPI {
  let baseUrl = "https://www.swapi.co/api/"

  public init() {
  }

  public func createRequest<T: BaseMappable>(_ url: String,
                                             completionHandler: @escaping (Alamofire.DataResponse<T>) -> Void)
                                                -> DataRequest {
    let headers: HTTPHeaders = [
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
    let requestUrl = baseUrl + url + "&format=json"

    return Alamofire.request(requestUrl, method: .get, headers: headers)
                      .responseObject(completionHandler: completionHandler)
  }
}

extension StarWarsAPI: NetworkService {

  public func fetchJson<T: Mappable & Codable>(_ url: String, completionHandler: @escaping (Result<T>) -> Void) {
    _ = self.createRequest(url) { (response: DataResponse<T>) in
      completionHandler(response.result)
    }
  }

  /// Creates a request to the Star Wars API and returns a promise with the expected result type
  public func fetchResponseJson<T: Mappable & Codable>(_ url: String) -> Single<T> {
    return Single<T>.create { single in
      _ = self.createRequest(url) { (response: DataResponse<T>) in
        switch response.result {
        case .success(let result):
          single(.success(result))
        case .failure(let error):
          single(.error(error))
        }
      }
      return Disposables.create()
    }
  }
}
