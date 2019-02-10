//
//  StarWarsAPI.swift
//  Networking
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift
import RxAlamofire

class StarWarsAPI {
  private static let baseUrl = "https://swapi.co/api/"

  // MARK: - Private

  private func createRequest(endpoint: String, params: [String: String]) -> Observable<Any> {
    let url = StarWarsAPI.baseUrl + endpoint
    // TODO: - Log everytime a request to a URL is made
    print("Requesting from url: \(url)")
    return json(.get, url, parameters: params)
  }

  // MARK: - Public

  /// Creates a request to the StarWarsAPI
  func buildRequest(endpoint: String, params: [String: String] = [:]) -> Observable<StarWarsAPIResponse> {
    let updatedParams = params.merging(["format": "json"]) { $1 }
    return createRequest(endpoint: endpoint, params: updatedParams).map { result in
      // TODO: - Safely unwrap
      let response = Mapper<StarWarsAPIResponse>().map(JSONObject: result)!
      return response
    }
  }
}
