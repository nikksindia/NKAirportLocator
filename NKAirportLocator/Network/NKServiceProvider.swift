//
//  NKServiceProvider.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 23/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

typealias SearchAirportResult = (NKNearbyResult?,Error?) -> ()

protocol NKAirportServiceProvider: AnyObject {
  func getNerabyAirports(latitude: Double,
                         longitude: Double,
                         completion: @escaping SearchAirportResult)
}
