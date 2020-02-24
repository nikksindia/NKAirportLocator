//
//  NKLocatorVC.swift
//  NKAirportLocator
//
//  Created by Nikhil Sharma on 22/02/20.
//  Copyright © 2020 AirAsiaSubmission. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class NKLocatorVC: UIViewController {

  //MARK: Properties
  @IBOutlet weak var mapView: MKMapView!
  private let viewModel = NKLocatorViewModel()
  private var locationManager: CLLocationManager?

  //MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupData()
    addViewModelHandlers()
  }

  //MARK: Private Methods - Layout Setup
  private func setupViews() {
    configureMapView()
  }
  private func configureMapView() {
    mapView.delegate = self
    mapView.mapType = .standard
    mapView.isZoomEnabled = true
    mapView.isScrollEnabled = true
  }
  private func resetAllAnnotations() {
    let annotations = mapView.annotations
    mapView.removeAnnotations(annotations)
  }
  private func addAnnotaionsOnMap(_ aryResults: [NKAirportModel]) {
    resetAllAnnotations()
    aryResults.forEach{ (result)  in
      let annotaion = NKAirportAnnotation(lat: result.lat,
                                          long: result.lng,
                                          name: result.name,
                                          dis: result.distance)
      mapView.addAnnotation(annotaion)
    }
  }

  //MARK: Private Methods - Data Setup
  private func setupData() {
    getCurrentLocation()
  }
  private func getCurrentLocation() {
    locationManager = CLLocationManager()
    locationManager?.requestWhenInUseAuthorization()
    locationManager?.delegate = self
    locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    locationManager?.startUpdatingLocation()
  }

  //MARK: Private Methods - Event Handlers
  private func addViewModelHandlers() {
    viewModel.fetchNearbyAirportsSuccess = { [weak self] (results) in
      DispatchQueue.main.async {
        self?.addAnnotaionsOnMap(results ?? [])
      }
    }
  }
}

//MARK: Location Manager Delegate
extension NKLocatorVC: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    guard let locValue:CLLocationCoordinate2D = manager.location?.coordinate
      else {return}
    let region = MKCoordinateRegion(center: locValue,
                                    latitudinalMeters: 15000.0,
                                    longitudinalMeters: 15000.0)
    mapView.setRegion(region, animated: true)
    viewModel.requestToGetNearbyAiportsTo(lat: locValue.latitude,
                                          long: locValue.longitude)
  }
}

//MARK: Map View Delegate
extension NKLocatorVC: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? NKAirportAnnotation else { return nil }
    let identifier = "nearbyMarker"
    var view: MKMarkerAnnotationView
    if let markerView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      as? MKMarkerAnnotationView {
      markerView.annotation = annotation
      view = markerView
    } else {
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
  }

  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    guard let annotation = view.annotation as? NKAirportAnnotation else { return }
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault]
    annotation.map.openInMaps(launchOptions: launchOptions)
  }
}
