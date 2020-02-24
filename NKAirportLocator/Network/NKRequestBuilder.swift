//
//  NKRequestBuilder.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 24/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

enum APIErrorCode: Error {
    case unknown
    case invalidRequest
    case requestFailed
    case modellingError
    case mockJSONNotFound
}

final class NKRequestBuilder {

  //MARK: Class Methods
  class func getRequest(route: NKAPIRoute,
                        params: [String: String]?,
                        headers: [String: String]?,
                        timeoutInterval: TimeInterval) -> URLRequest? {

    var request: URLRequest?

    let urlString = NKNetworkConfig.baseURL + route.rawValue + (params?.stringFromHttpParameters() ?? "")

    if let url = URL(string: urlString) {
      request = URLRequest(url: url,
                           timeoutInterval: timeoutInterval)
      request?.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
      request?.httpMethod = "GET"
      //HTTP Headers
      if let headers = headers {
        for (key, value) in headers {
          request?.setValue(value,
                            forHTTPHeaderField: key)
        }
      }
    }
    return request
  }
}
