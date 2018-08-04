//
//  PageResponse.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/2/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Foundation
import ObjectMapper

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
