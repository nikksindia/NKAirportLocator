//
//  NKAirportModel.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 23/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

struct NKNearbyResult: Codable {
  let geonames: [NKAirportModel]?
}

struct NKAirportModel: Codable {
  let adminCode1: String
  let lng: String
  let lat: String
  let distance: String
  let geonameId: Int64
  let toponymName: String
  let countryId: String
  let fcl: String
  let population: Int64
  let countryCode: String
  let name: String
  let fclName: String
  let countryName: String
  let adminName1: String
  let fcode: String
}
