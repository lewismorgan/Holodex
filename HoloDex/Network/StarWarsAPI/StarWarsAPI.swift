//
//  StarWarsAPI.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

final class StarWarsAPI: NetworkingAPI {
  private static let baseUrl = "https://swapi.co/api/"

  public init() {
  }

  // MARK: - Private Functions

  private func createListRequest<T: Decodable>(endpoint: String, params: [String: Any],
                                               type: T.Type) -> Observable<SWAPIListResponse<T>> {
    return Observable.create { observer in
      let url = StarWarsAPI.baseUrl + endpoint

      let request = AF.request(url, parameters: params)
        .responseDecodable { (response: DataResponse<SWAPIListResponse<T>, AFError>) in
          switch response.result {
          case .success(let value):
            observer.on(.next(value))
            observer.on(.completed)
          case .failure(let error):
            print(error)
            observer.on(.error(error))
          }
        }
      return Disposables.create {
        request.cancel()
      }
    }.debug()
  }

  // MARK: - NetworkingAPI

  public func createRequest<T: Decodable>(endpoint: String, params: [String: Any] = [:], type: T.Type = T.self) -> Observable<T> {
    // TODO: Logging
    return Observable.create { observer in
      let request = AF.request(StarWarsAPI.baseUrl + endpoint, parameters: params).responseDecodable(of: T.self) { response in
        switch response.result {
        case .success(let value):
          observer.on(.next(value))
          observer.on(.completed)
        case .failure:
          observer.on(.error(NetworkAPIError.nullMapping))
        }
      }
      return Disposables.create {
        request.cancel()
      }
    }
  }

  public func createPageRequest<T: Decodable>(endpoint: String, from: Int, until: Int?, type: T.Type) -> Observable<[T]> {
    return createListRequest(endpoint: endpoint, params: ["page": from], type: type.self)
      .flatMap { (response: SWAPIListResponse<T>) -> Observable<[T]> in
        if until == nil || from != until, let page = response.findNextPage() {
          // Another page, continue the stream
          return Observable.concat(Observable.just(response.results), self.createPageRequest(endpoint: endpoint, from: page,
                                                                                             until: until, type: type))
        } else {
          // No more pages of data
          return Observable.just(response.results)
        }
      }
  }
}

extension SWAPIListResponse {
  func findNextPage() -> Int? {
    guard let next = next else {
      return nil
    }

    let components = NSURLComponents(string: next)

    if let items = components?.queryItemsToDict(), let page = items["page"] {
      return Int(page)
    } else {
      return nil
    }
  }
}
