//
//  NetworkingAPI.swift
//  Networking
//
//  Created by Lewis Morgan on 2/14/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import RxSwift
import ObjectMapper

public protocol NetworkingAPI {
  func buildRequest<T: Mappable>(endpoint: String, params: [String: Any], type: T.Type) -> Observable<T>
  func buildPageRequest<T: Mappable>(endpoint: String, page: Int, type: T.Type) -> Observable<PagedResults<T>>
}
