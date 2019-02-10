//
//  StarWarsAPIResponse.swift
//  Networking
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import ObjectMapper

public class StarWarsAPIResponse: Mappable {
  public var count: Int = 0
  public var next: String = ""
  public var previous: String = ""
  public var results: [[String: Any]] = []

  public init() {

  }

  public required init?(map: Map) {
  }

  public func mapping(map: Map) {
    count       <- map["count"]
    next        <- map["next"]
    previous    <- map["previous"]
    results     <- map["results"]
  }
}
