//
//  Location.swift
//  FoodJournal
//
//  Created by Ace on 17/6/2026.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    let latitude: Double
    let longitude: Double
    let timestamp: Date
    
    init(latitude: Double, longitude: Double, timestamp: Date = Date()) {
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
    }
    
    init?(from clLocation: CLLocation?) {
        guard let clLocation else { return nil }
        self.latitude = clLocation.coordinate.latitude
        self.longitude = clLocation.coordinate.longitude
        self.timestamp = clLocation.timestamp
    }
}
