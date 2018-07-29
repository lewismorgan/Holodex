//
//  Result.swift
//  HoloDex
//
//  Created by Lewis Morgan on 7/29/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

enum Result<Value> {
  case success(Value)
  case failure(Error)
}
