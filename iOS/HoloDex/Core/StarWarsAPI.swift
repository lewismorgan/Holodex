//
//  StarWarsAPI.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import PromiseKit

protocol NetworkService {
  func fetchResponseJson(_ url: String) -> Promise<(json: Any, response: PMKAlamofireDataResponse)>
}

class StarWarsAPI: NetworkService {
  func fetchResponseJson(_ url: String) -> Promise<(json: Any, response: PMKAlamofireDataResponse)> {
    return Alamofire.request(url, method: .get).responseJSON()
  }
}
