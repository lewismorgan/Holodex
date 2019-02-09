//
//  People.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ObjectMapper

public struct Person: Mappable, Codable {
  public var name: String?
  public var height: String?
  public var mass: String?
  public var hairColor: String?
  public var skinColor: String?
  public var eyeColor: String?
  public var birthYear: String?
  public var gender: String?
  public var homeworld: String?

  public init() {
  }

  public init(name: String) {
    self.name = name
  }

  public init?(map: Map) {
  }

  public mutating func mapping(map: Map) {
    name        <- map["name"]
    height      <- map["height"]
    mass        <- map["mass"]
    hairColor   <- map["hair_color"]
    skinColor   <- map["skin_color"]
    eyeColor    <- map["eye_color"]
    birthYear   <- map["birth_year"]
    gender      <- map["gender"]
    homeworld   <- map["homeworld"]
  }
}
