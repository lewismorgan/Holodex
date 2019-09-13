//
//  StarWarsAPIResponse.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

struct SWAPIListResponse<T: Decodable>: Decodable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [T]
}
