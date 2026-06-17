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
}
