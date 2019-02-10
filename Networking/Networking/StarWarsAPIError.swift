//
//  StarWarsAPIError.swift
//  Networking
//
//  Created by Lewis Morgan on 2/10/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

enum StarWarsAPIError: Error, Equatable {
  case noPages
  case badEndpoint
  public static func == (lhs: StarWarsAPIError, rhs: StarWarsAPIError) -> Bool {
    switch (lhs, rhs) {
    case (.noPages, .noPages):
      return true
    default:
      return false
    }
  }
}
