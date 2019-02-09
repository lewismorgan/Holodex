//
//  StarWarsAPI.swift
//  Network
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Alamofire

public class StarWarsAPI {
  private static let baseUrl = "https://www.swapi.co/api/"
  
  private func buildRequest() {
    
  }
}

public enum NetworkError: String, Error {
  case invalidEndpoint
}
