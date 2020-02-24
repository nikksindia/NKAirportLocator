//
//  NKMockDataManager.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 24/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

final class NKMockDataManager {
  
  class func readMockDataFromFile(_ fileName: String) -> Data? {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
      else { return nil }
    do {
      let data = try Data(contentsOf: url)
      return data
    } catch let error {
      debugPrint(error)
      return nil
    }
  }
}
