//
//  NKDictionaryExtension.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 24/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation

extension Dictionary where Key : CustomStringConvertible, Value : CustomStringConvertible {
  
  func stringFromHttpParameters() -> String {
    var parametersString = "?"
    for (key, value) in self {
      parametersString += key.description + "=" + value.description + "&"
    }
    return String(parametersString.dropLast())
  }
}
