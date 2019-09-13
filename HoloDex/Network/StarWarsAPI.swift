//
//  StarWarsAPI.swift
//  HoloDex
//
//  Created by Lewis Morgan on 2/9/19.
//  Copyright © 2019 Lewis Morgan. All rights reserved.
//

import Alamofire
import Foundation
import LoggerAPI
import RxSwift

final class StarWarsAPI: NetworkAPI {
  private static let baseUrl = "https://swapi.co/api/"

  public init() {
  }

  // MARK: - Private Functions

  private func createListRequest<T: Decodable>(endpoint: String, params: [String: Any],
                                               type: T.Type) -> Observable<SWAPIListResponse<T>> {
    Log.debug("Request from \(endpoint) with: \(params)")
    return Observable.create { observer in
      Log.debug("Thread Is Main: \(Thread.isMainThread)")
      let request = AF.request(StarWarsAPI.baseUrl + endpoint, parameters: params)
        .responseDecodable { (response: DataResponse<SWAPIListResponse<T>, AFError>) in
          switch response.result {
          case .success(let value):
            observer.on(.next(value))
            observer.on(.completed)
          case .failure(let error):
            Log.error("\(error)")
            observer.on(.error(error))
          }
        }
      return Disposables.create {
        request.cancel()
      }
    }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
  }

  // MARK: - NetworkingAPI

  public func createRequest<T: Decodable>(endpoint: String, params: [String: Any] = [:], type: T.Type = T.self) -> Observable<T> {
    Log.debug("Request from \(endpoint) with: \(params)")
    return Observable.create { observer in
      Log.debug("Thread Is Main: \(Thread.isMainThread)")
      let request = AF.request(StarWarsAPI.baseUrl + endpoint, parameters: params).responseDecodable(of: T.self) { response in
        switch response.result {
        case .success(let value):
          observer.on(.next(value))
          observer.on(.completed)
        case .failure(let error):
          Log.error("\(error)")
          observer.on(.error(NetworkAPIError.nullMapping))
        }
      }
      return Disposables.create {
        request.cancel()
      }
    }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
  }

  public func createPageRequest<T: Decodable>(endpoint: String, from: Int, until: Int?, type: T.Type) -> Observable<[T]> {
    Log.debug("Page Requested for \(endpoint)")
    return createListRequest(endpoint: endpoint, params: ["page": from], type: type.self)
      .flatMap { (response: SWAPIListResponse<T>) -> Observable<[T]> in
        if until == nil || from != until, let page = response.findNextPage() {
          // Another page, continue the stream
          return Observable.concat(Observable.just(response.results),
                                   self.createPageRequest(endpoint: endpoint, from: page, until: until, type: type))
        } else {
          // No more pages of data
          return Observable.just(response.results)
        }
      }
  }
}

struct SWAPIListResponse<T: Decodable>: Decodable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [T]
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
