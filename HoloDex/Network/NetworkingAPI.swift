//
//  NetworkingAPI.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis J Morgan. All rights reserved.
//

import RxSwift

public protocol NetworkingAPI {
  func createRequest<T: Decodable>(endpoint: String, params: [String: Any], type: T.Type) -> Observable<T>
  func createPageRequest<T: Decodable>(endpoint: String, from: Int, to: Int?, type: T.Type) -> Observable<[T]>
}
