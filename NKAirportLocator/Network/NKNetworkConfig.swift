//
//  NKNetworkConfig.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 23/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

struct NKNetworkConfig {
  // General Config
  static let requestTimeout = 30.0
  static let baseURL = "http://api.geonames.org/"
  static let authUserName = "joker"
  static let maxResults = 100

  // Airport Service Config
  static let serviceCode = "AIRP"
  static let serviceName = "airport"
  static let radius = 25
}

struct NKAPIRoutes {
  static let nearbyAirports = "findNearbyJSON"
}
