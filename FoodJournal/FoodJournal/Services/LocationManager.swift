//
//  LocationManager.swift
//  FoodJournal
//
//  Created by Ace on 17/6/2026.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    var currentLocation: Location? { get }
    var authorizationStatus: CLAuthorizationStatus { get }
    var locationError: Error? { get }
    
    func requestAuthorization()
    func requestLocation()
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func getCurrentLocation() -> Location?
}

@Observable
class LocationManager:
    NSObject, CLLocationManagerDelegate, LocationManagerProtocol
{
    private let manager = CLLocationManager()
    private(set) var currentLocation: Location?
    private(set) var authorizationStatus: CLAuthorizationStatus = .notDetermined
    private(set) var locationError: Error?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        authorizationStatus = manager.authorizationStatus
    }
    
    /// Request location authorization from the user
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    /// Start monitoring location updates
    func startUpdatingLocation() {
        guard authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways else {
            requestAuthorization()
            return
        }
        manager.startUpdatingLocation()
    }
    
    /// Stop monitoring location updates
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
    
    /// Get the current location synchronously (returns cached location if available)
    func getCurrentLocation() -> Location? {
        return currentLocation
    }
    
    /// Request a single location update
    func requestLocation() {
        guard authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways else {
            requestAuthorization()
            return
        }
        manager.requestLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = Location(from: location)
            locationError = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = error
        print("Location error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            print("Location access denied or restricted")
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
}
