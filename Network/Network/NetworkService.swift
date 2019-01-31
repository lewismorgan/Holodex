//
//  NetworkService.swift
//  Core
//
//  Created by Lewis Morgan on 8/10/18.
//  Copyright © 2018 Lewis J Morgan. All rights reserved.
//

import RxSwift
import ObjectMapper
import Alamofire

public protocol NetworkService {
  func fetchResponseJson<T: Mappable & Codable>(_ url: String) -> Single<T>
  func fetchJson<T: Mappable & Codable>(_ url: String, completionHandler: @escaping (Result<T>) -> Void)
}
