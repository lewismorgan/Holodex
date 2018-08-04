//
//  People.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ObjectMapper

struct Person: Mappable, Codable {
  var name: String?
  var height: String?
  var mass: String?
  var hairColor: String?
  var skinColor: String?
  var eyeColor: String?
  var birthYear: String?
  var gender: String?
  var homeworld: String?

  init() {
  }

  init?(map: Map) {
  }

  mutating func mapping(map: Map) {
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
