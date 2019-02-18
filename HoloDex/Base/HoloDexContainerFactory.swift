//
//  ReleaseContainer.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/18/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import Networking
import People
import Swinject

/// Allows HoloDex to use specific implementations of protocols depending on a HoloDexContainer
class HoloDexContainerFactory {

  /// Create a Container from a raw string value. Wrapper around create(type:) that passes in the HoloDexContainer
  /// that matches HoloDexContainer.init(rawValue:). fatalError thrown if no values matching the value param.
  public static func fromRaw(value: String) -> Container {
    // swiftlint:disable explicit_init
    guard let type = HoloDexContainer.init(rawValue: value) else {
      fatalError("🛑 Unknown container value: \(value)")
    }
    // swiftlint:enable explicit_init
    return create(type: type)
  }

  /// Returns a Container from a HoloDexContainer
  public static func create(type: HoloDexContainer) -> Container {
    switch type {
    case .debug:
      return debug()
    case .release:
      return release()
    }
  }

  // Debugging Implementations
  private static func debug() -> Container {
    let container = Container()
    container.register(PeopleEndpoint.self) { _ in RandomPeopleEndpoint() }
    return container
  }

  // Release Implementations
  private static func release() -> Container {
    let container = Container()
    container.register(PeopleEndpoint.self) { _ in StarWarsAPI() }
    return container
  }
}

enum HoloDexContainer: String {
  case debug
  case release
}
