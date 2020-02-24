//
//  NKLocatorViewModelTests.swift
//  NKAirportLocatorTests
//
//  Created by Nikhil Sharma on 24/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import XCTest
@testable import NKAirportLocator

class NKLocatorViewModelTests: XCTestCase {

  private var viewModel: NKLocatorViewModel?
  private var testLatitude: Double?
  private var testLongitude: Double?

  override func setUp() {
    viewModel = NKLocatorViewModel(serviceProvider: NKMockServiceManager())
    testLatitude = 28.5355
    testLongitude = 77.3910
  }

  override func tearDown() {
    viewModel = nil
    testLatitude = nil
    testLongitude = nil
  }

  func testRequestToGetNearbyAiportsTo() {
    guard let lat = testLatitude, let long = testLongitude else { return }
    // Success Event Handler
    viewModel?.fetchNearbyAirportsSuccess = { (results) in
      XCTAssertEqual(results?.count, 3)
    }
    // Error Event Handler
    viewModel?.showAlertMessage = { (message) in
      XCTAssertNotEqual(message, "")
    }
    // Get nearby airports
    viewModel?.requestToGetNearbyAiportsTo(lat: lat, long: long)
  }
}
