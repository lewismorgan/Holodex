//
//  HoloDexError.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/3/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Foundation

protocol HoloDexError: LocalizedError {
  var title: String? { get }
  var code: Int { get }
}

struct GeneralHoloDexError: HoloDexError {
  var title: String?
  var code: Int
  var errorDescription: String? { return _description }
  var failureReason: String? { return _description }

  private var _description: String

  init(title: String?, description: String, code: Int) {
    self.title = title ?? "Error"
    self._description = description
    self.code = code
  }
}
