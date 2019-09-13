//
//  People.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/25/18.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

struct Person: Decodable {
  let name: String
  let height: String = ""
  let mass: String = ""
  let hairColor: String = ""
  let skinColor: String = ""
  let eyeColor: String = ""
  let birthYear: String = ""
  let gender: String = ""
  let homeworld: String = ""
  let films: [String] = []
  let species: [String] = []
  let vehicles: [String] = []
  let starships: [String] = []

  init() {
    self.name = ""
  }

  init(name: String) {
    self.name = name
  }
  enum CodingKeys: String, CodingKey {
    case name, height, mass
    case hairColor = "hair_color"
    case skinColor = "skin_color"
    case eyeColor = "eye_color"
    case birthYear = "birth_year"
    case gender, homeworld, films, species, vehicles, starships
  }
}
