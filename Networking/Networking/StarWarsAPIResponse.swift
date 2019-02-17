//
//  StarWarsAPIResponse.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import ObjectMapper

public class StarWarsAPIResponse<T: Mappable>: Mappable {
  public var count: Int = 0
  public var next: String = ""
  public var previous: String = ""
  public var results: [T] = []

  public init() {

  }

  public required init?(map: Map) {
  }

  public func mapping(map: Map) {
    count <- map["count"]
    next <- map["next"]
    previous <- map["previous"]
    results <- map["results"]
  }
}
