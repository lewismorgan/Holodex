//
//  StarWarsAPI.swift
//  Networking
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Alamofire
import ObjectMapper
import RxSwift
import RxAlamofire

public class StarWarsAPI {
  private static let baseUrl = "https://swapi.co/api/"

  // MARK: - Private

  private func createRequest(endpoint: String, params: [String: Any]) -> Observable<Any> {
    let url = StarWarsAPI.baseUrl + endpoint
    // TODO: - Log everytime a request is created instead of printing
    print("endpoint: \(endpoint) | params: \(params)")
    return json(.get, url, parameters: params)
  }

  // MARK: - Public

  /// Creates a request to the StarWarsAPI
  public func buildRequest<T: Mappable>(endpoint: String, params: [String: Any] = [:], type: T.Type) -> Observable<T> {
    return createRequest(endpoint: endpoint, params: params.merging(["format": "json"]) { $1 }).map { result in
      guard let response = Mapper<T>().map(JSONObject: result) else {
        throw StarWarsAPIError.nullMapping
      }
      return response
    }
  }
  
  /// Creates a request that has multiple pages that will observe the next page when the trigger has a value emitted
  public func buildPageRequest<T: Mappable>(endpoint: String, page: Int = 1,
                                             loadNext trigger: Observable<Void>, type: T.Type) -> Observable<[T]> {
    return buildRequest(endpoint: endpoint, params: ["page": page], type: StarWarsAPIResponse<T>.self)
      .flatMap { (response) -> Observable<[T]> in
        let components = NSURLComponents(string: response.next)
        guard let items = components?.queryItemsToDict(), let page = items["page"] else {
          // There are no more pages
          return Observable.of(response.results)
        }
        if let nextPage = Int(page) {
          return Observable.concat(Observable.of(response.results), Observable.never().takeUntil(trigger),
                                   self.buildPageRequest(endpoint: endpoint, page: nextPage, loadNext: trigger, type: type))
        } else { return Observable.of(response.results) }
    }
  }
}
