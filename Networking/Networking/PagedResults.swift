//
//  PagedResults.swift
//  Networking
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import ObjectMapper

public class PagedResults<T: Mappable> {
  let count: Int
  let nextPage: Int
  let results: [T]
  
  init(count: Int, nextPage: Int, results: [T]) {
    self.count = count
    self.nextPage = nextPage
    self.results = results
  }
}
