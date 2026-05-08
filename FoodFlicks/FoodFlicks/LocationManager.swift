//
//  LocationManager.swift
//  FoodFlicks
//
//  Created by Ace on 8/5/2026.
//

import CoreLocation

extension Notification.Name {
    static let locationDidUpdate = Notification.Name("locationDidUpdate")
}

@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var userLocation: CLLocation?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestAuthorization() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }

    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        if let location = userLocation {
            NotificationCenter.default.post(name: .locationDidUpdate, object: location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {}
}
