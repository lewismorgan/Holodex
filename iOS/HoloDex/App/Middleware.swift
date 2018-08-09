//
//  Middlewear.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/30/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import ReSwift

typealias MiddlewareItem = (Action, @escaping DispatchFunction) -> Void

func createMiddlewareChain(items: [MiddlewareItem]) -> Middleware<AppState> {
  return { dispatch, getState in
    return { next in
      return { action in
        items.forEach { $0(action, dispatch) }
        return next(action)
      }
    }
  }
}
