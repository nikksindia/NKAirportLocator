//
//  NKServiceManager.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 23/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

typealias Response = (_ data: Data?, _ error: Error?) -> (Void)

final class NKAirportService: NKAirportServiceProvider {
  
  //MARK: Public Methods
  func getNerabyAirports(latitude: Double,
                         longitude: Double,
                         completion: @escaping SearchAirportResult) {

    let urlString = requestURLString(lat: latitude, long: longitude)
    getData(urlString: urlString) { (response, error) -> () in
      guard error == nil,
        let responseData = response else {
          completion(nil, error)
          return
      }
      do {
        let object = try JSONDecoder().decode(NKNearbyResult.self, from: responseData)
        completion(object,nil)
      } catch let error {
        completion(nil,error)
      }
    }
  }

  //MARK:- Private methods
  private func getData(urlString: String,
                       params: [AnyHashable: Any]? = nil,
                       headers: [String: String]? = nil,
                       completion: @escaping Response) {

    guard let request = NKRequestBuilder.getRequest(urlString: urlString,
                                                 params: params,
                                                 headers: headers,
                                                 timeoutInterval: NKNetworkConfig.requestTimeout)
      else {
        completion(nil, APIErrorCode.invalidRequest)
        return
    }
    let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
      completion(data, error)
    }
    dataTask.resume()
  }

  private func requestURLString(lat: Double, long: Double) -> String {
    let requestURLString = "\(NKNetworkConfig.baseURL)\(NKAPIRoutes.nearbyAirports)?lat=\(lat)&lng=\(long)&fcodeName=\(NKNetworkConfig.serviceName)&fcode=\(NKNetworkConfig.serviceCode)&radius=\(NKNetworkConfig.radius)&maxRows=\(NKNetworkConfig.maxResults)&username=\(NKNetworkConfig.authUserName)"
    return requestURLString
  }
  
}
