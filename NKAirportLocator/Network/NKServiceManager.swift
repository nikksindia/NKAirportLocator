//
//  NKServiceManager.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 23/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

typealias Response = (_ data: Data?, _ error: Error?) -> ()

final class NKAirportService: NKAirportServiceProvider {
  
  //MARK: Public Methods
  func getNerabyAirports(latitude: Double,
                         longitude: Double,
                         completion: @escaping SearchAirportResult) {
    let requestParams = nearbyAirportsRequestParams(lat: latitude, long: longitude)
    getData(route: .nearbyAirports,
            params: requestParams) { (response, error) -> () in
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
  private func nearbyAirportsRequestParams(lat latitude: Double,
                                           long longitude: Double) -> [String: String] {
    let requestDict = ["lat":"\(latitude)", "lng": "\(longitude)",
                       "fcodeName": NKNetworkConfig.serviceName,
                       "fcode": NKNetworkConfig.serviceCode,
                       "radius": "\(NKNetworkConfig.radius)",
                       "maxRows": "\(NKNetworkConfig.maxResults)",
                       "username": NKNetworkConfig.authUserName]
    return requestDict
  }
  private func getData(route: NKAPIRoute,
                       params: [String: String]? = nil,
                       headers: [String: String]? = nil,
                       completion: @escaping Response) {

    guard let request = NKRequestBuilder.getRequest(route: route,
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
}
