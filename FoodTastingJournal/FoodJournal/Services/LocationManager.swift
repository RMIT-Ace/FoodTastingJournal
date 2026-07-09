//
//  LocationManager.swift
//  FoodJournal
//
//  Created by Ace on 17/6/2026.
//

import Foundation
import CoreLocation

@Observable
class LocationManager {
    var currentLocation: CLLocation?
    var visitedRestaurants: [Restaurant] = []
    var nearByDistance: Double = 100 // meters
    
    var nearByRestaurants: [Restaurant] {
        guard let currentLocation else { return [] }
        return visitedRestaurants.filter {
            $0.location.distance(from: currentLocation) <= nearByDistance
        }
    }

    func startUpdatingCurrentLocation() async {
        do {
            // Start continuous updating of location.
            for try await update in CLLocationUpdate.liveUpdates() {
                if let location = update.location {
                    currentLocation = location
                } else if update.authorizationDenied {
                    print(">> WARNING: Location access denied")
                    break
                }
            }
        } catch {
            print(">> WARNING: Location updates failed: \(error.localizedDescription)")
        }
    }
}
