//
//  NKMockServiceManager.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 24/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

class NKMockServiceManager: NKAirportServiceProvider {

  func getNerabyAirports(latitude: Double,
                         longitude: Double,
                         completion: @escaping SearchAirportResult) {

    if let response = NKMockDataManager.readMockDataFromFile("NearbyAirportsMock") {
        do {
            let object = try JSONDecoder().decode(NKNearbyResult.self, from: response)
            completion(object,nil)
        } catch let error {
            completion(nil,error)
        }
    } else {
        completion(nil, APIErrorCode.mockJSONNotFound)
    }
  }


}
