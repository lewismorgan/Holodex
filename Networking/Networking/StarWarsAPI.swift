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

class StarWarsAPI {
  private static let baseUrl = "https://swapi.co/api/"

  // MARK: - Private

  private func createRequest(endpoint: String, params: [String: Any]) -> Observable<Any> {
    let url = StarWarsAPI.baseUrl + endpoint
    // TODO: - Log everytime a request is created instead of printing
    print("Requesting from url: \(url)")
    return json(.get, url, parameters: params)
  }

  // MARK: - Public

  /// Creates a request to the StarWarsAPI
  func buildRequest<T: Mappable>(endpoint: String,
                                 params: [String: Any] = [:], type: T.Type) -> Observable<StarWarsAPIResponse<T>> {
    return createRequest(endpoint: endpoint, params: params.merging(["format": "json"]) { $1 }).map { result in
      guard let response = Mapper<StarWarsAPIResponse<T>>().map(JSONObject: result) else {
        throw StarWarsAPIError.nullMapping
      }
      return response
    }
  }
  
  /// Given a StarWarsAPIResponse, builds a request for the next page
  func buildNextRequest<T: Mappable>(current: StarWarsAPIResponse<T>, type: T.Type) -> Observable<StarWarsAPIResponse<T>> {
    let components = NSURLComponents(string: current.next)
    guard let items = components?.queryItemsToDict(), let page = items["page"] else {
      return Observable.error(StarWarsAPIError.noPages)
    }
    
    guard let endpoint = components?.lastEndpoint(from: "/api/".count) else {
      return Observable.error(StarWarsAPIError.badEndpoint)
    }
    
    if page != "" {
      return buildRequest(endpoint: endpoint, params: ["page" : page], type: type)
    } else {
      return Observable.error(StarWarsAPIError.noPages)
    }
  }
}
