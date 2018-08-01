//
//  StarWarsAPI.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Alamofire
import Promises

protocol NetworkService {
  func fetchResponseJson(_ url: String) -> Promise<Any>
}

class StarWarsAPI: NetworkService {
  let baseUrl = "https://swapi.co/api/"

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
