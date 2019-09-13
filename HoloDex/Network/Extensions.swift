//
//  Extensions.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/10/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Foundation

extension NSURLComponents {
  func lastEndpoint(from index: Int) -> String {
    guard let path = self.path else {
      return ""
    }
    let endpoint = path.dropLast().dropFirst(index)
    return String(endpoint)
  }

  func queryItemsToDict() -> [String: String] {
    guard let items = self.queryItems else {
      return [:]
    }
    var queryDict: [String: String] = [:]

    items.forEach { item in
      queryDict[item.name] = item.value != nil ? item.value : ""
    }
    return queryDict
  }
}
