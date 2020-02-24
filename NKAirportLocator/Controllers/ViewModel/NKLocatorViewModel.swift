//
//  NKLocatorViewModel.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 22/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

final class NKLocatorViewModel {
  //MARK: Properties
  private let serviceProvider: NKAirportServiceProvider
  private var alertMessage: String? {
    didSet {
      showAlertMessage?(alertMessage)
    }
  }
  public var fetchNearbyAirportsSuccess: (([NKAirportModel]?)->())?
  public var showAlertMessage: ((String?)->())?


  //MARK: Initializers
  init(serviceProvider: NKAirportServiceProvider = NKAirportService()) {
    self.serviceProvider = serviceProvider
  }

  //MARK: Public Methods
  public func requestToGetNearbyAiportsTo(lat latitude: Double,long longitude: Double) {
    serviceProvider.getNerabyAirports(latitude: latitude,
                                      longitude: longitude) {[weak self] (results, error) in
                                        if error == nil {
                                          self?.fetchNearbyAirportsSuccess?(results?.geonames)
                                        } else {
                                          self?.alertMessage = error.debugDescription
                                        }

    }
  }
}
