//
//  NKAirportAnnotation.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 24/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class NKAirportAnnotation: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  var map: MKMapItem {
    let dict = [CNPostalAddressStreetKey: title ?? ""]
    let placemark = MKPlacemark(coordinate: coordinate,
                                addressDictionary: dict)
    let item = MKMapItem(placemark: placemark)
    item.name = title
    return item
  }

  init(lat latitude: String,
                long longitude: String,
                name airportName: String,
                dis distance: String) {
    self.title = airportName
    self.subtitle = distance + " kms away"
    self.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0.0,
                                             longitude: Double(longitude) ?? 0.0)

    super.init()
  }
}
