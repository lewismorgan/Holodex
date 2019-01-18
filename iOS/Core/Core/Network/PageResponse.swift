//
//  PageResponse.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/2/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Foundation
import ObjectMapper

public struct PageResponse<T: Mappable & Codable>: Mappable, Codable {
  public var count: Int?
  public var next: String?
  public var previous: String?
  public var results: [T]?

  public init?(map: Map) {
  }

  public mutating func mapping(map: Map) {
    count <- map["count"]
    next <- map["next"]
    previous <- map["previous"]
    results <- map["results"]
  }
}
