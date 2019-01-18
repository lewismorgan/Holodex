//
//  HoloDexError.swift
//  HoloDex
//
//  Created by Lewis Morgan on 8/3/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import Foundation

public protocol HoloDexError: LocalizedError {
  var title: String? { get }
  var code: Int { get }
}

public struct GeneralHoloDexError: HoloDexError {
  public var title: String?
  public var code: Int
  public var errorDescription: String? { return _description }
  public var failureReason: String? { return _description }

  public var _description: String

  public init(title: String?, description: String, code: Int) {
    self.title = title ?? "Error"
    self._description = description
    self.code = code
  }
}
