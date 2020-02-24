//
//  NKRequestBuilder.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 24/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

class NKRequestBuilder {

  //MARK: Class Methods
  class func getRequest(urlString: String,
                        params: [AnyHashable: Any]?,
                        headers: [String: String]?,
                        timeoutInterval: TimeInterval) -> URLRequest? {

    var request: URLRequest?

    if let url = URL(string: urlString) {
      request = URLRequest(url: url, timeoutInterval: timeoutInterval)
      request?.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
      request?.httpMethod = "GET"
      //HTTP Headers
      if let headers = headers {
        for (key, value) in headers {
          request?.setValue(value, forHTTPHeaderField: key)
        }
      }
      //HTTP Body
      if let body = params {
        do {
          request?.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch let error {
          debugPrint(error.localizedDescription)
        }
      }
    }
    return request
  }
}
