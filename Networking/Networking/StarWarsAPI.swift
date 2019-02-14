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

public class StarWarsAPI: NetworkingAPI {
  private static let baseUrl = "https://swapi.co/api/"

  public init() {
  }

  // MARK: - Private

  private func createRequest(endpoint: String, params: [String: Any]) -> Observable<Any> {
    let url = StarWarsAPI.baseUrl + endpoint
    // TODO: - Log everytime a request is created instead of printing
    print("endpoint: \(endpoint) | params: \(params)")
    return json(.get, url, parameters: params)
  }

  // MARK: - NetworkingAPI Implementation

  /// Creates a request to the StarWarsAPI
  public func buildRequest<T: Mappable>(endpoint: String, params: [String: Any] = [:], type: T.Type) -> Observable<T> {
    return createRequest(endpoint: endpoint, params: params.merging(["format": "json"]) { $1 }).map { result in
      guard let response = Mapper<T>().map(JSONObject: result) else {
        throw NetworkAPIError.nullMapping
      }
      return response
    }
  }

  /// Creates a request for a specific page in the StarWarsAPI
  public func buildPageRequest<T: Mappable>(endpoint: String, page: Int, type: T.Type) -> Observable<PagedResults<T>> {
    return buildRequest(endpoint: endpoint, params: ["page": page], type: StarWarsAPIResponse<T>.self)
      .flatMap { (response) -> Observable<PagedResults<T>> in
        // Convert the URL page
        let components = NSURLComponents(string: response.next)
        guard let items = components?.queryItemsToDict(), let page = items["page"] else {
          // There are no more pages
          return Observable.error(NetworkAPIError.noPages)
        }
        if let nextPage = Int(page) {
          return Observable.just(PagedResults(count: response.count, nextPage: nextPage, results: response.results))
        } else {
          return Observable.error(NetworkAPIError.noPages)
        }
    }
  }

  // MARK: - Public Unique Methods

  /// Creates a request that has multiple pages that will observe the next page when the trigger has a value emitted
  public func buildStreamingPageRequest<T: Mappable>(endpoint: String, page: Int,
                                                     loadNext trigger: Observable<Void>, type: T.Type) -> Observable<[T]> {
    return buildRequest(endpoint: endpoint, params: ["page": page], type: StarWarsAPIResponse<T>.self)
      .flatMap { (response) -> Observable<[T]> in
        let components = NSURLComponents(string: response.next)
        guard let items = components?.queryItemsToDict(), let page = items["page"] else {
          // There are no more pages
          return Observable.of(response.results)
        }
        if let nextPage = Int(page) {
          return Observable.concat(Observable.just(response.results),
                                   Observable.never().takeUntil(trigger),
                                   self.buildStreamingPageRequest(endpoint: endpoint, page: nextPage, loadNext: trigger, type: type)
                                    .catchErrorJustReturn([]))
        } else { return Observable.just(response.results) }
    }
  }
}
