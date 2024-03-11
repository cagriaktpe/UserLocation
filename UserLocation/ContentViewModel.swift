//
//  ContentViewModel.swift
//  UserLocation
//
//  Created by Samet Çağrı Aktepe on 8.03.2024.
//

import MapKit
import SwiftUI

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 41.0082, longitude: 28.9784)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapRegion: MapCameraPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: MapDetails.startingLocation, span: MapDetails.defaultSpan))
    
    @Published var selectedRegion: MKCoordinateRegion?
    
    @Published var selectedCoordinate: CLLocationCoordinate2D?
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            //locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            print("Location services are not enabled")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted")
        case .denied:
            print("Your location is denied")
        case .authorizedAlways, .authorizedWhenInUse:
            setUserLocation()
        @unknown default:
            break
        }
    }
    
    func setUserLocation() {
        guard let userLocation = locationManager?.location?.coordinate else { return }
        mapRegion = MapCameraPosition.region(
            MKCoordinateRegion(
                center: userLocation, span: MapDetails.defaultSpan))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
