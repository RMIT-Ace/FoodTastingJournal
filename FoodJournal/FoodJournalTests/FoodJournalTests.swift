//
//  FoodJournalTests.swift
//  FoodJournalTests
//
//  Created by Ace on 1/6/2026.
//

import Testing
import Foundation
import CoreLocation

@testable import FoodTastingJournal

struct FoodJournalTests {
    
    static let melbLocation = CLLocation(latitude: -37.8136, longitude: 144.9631)
    
    static let nearRestaurants: [Restaurant] = [
        Restaurant(name: "Restaurant 1",
            location: .init( latitude: -37.8136, longitude: 144.9632 )
        ),
        Restaurant(name: "Restaurant 2",
            location: .init( latitude: -37.8137, longitude: 144.9633 )
        ),
    ]
    
    static let farRestaurants: [Restaurant] = [
        Restaurant(name: "Restaurant 3",
            location: .init( latitude: -37.8136, longitude: 144.9742 )
        ),
        Restaurant(name: "Restaurant 4",
            location: .init( latitude: -37.8137, longitude: 144.9743 )
        ),
    ]
    

    static let visitedRestaurants: [Restaurant] = {
        nearRestaurants + farRestaurants
    }()
    
    let locationManager: LocationManager = {
        let manager = LocationManager()
        manager.currentLocation = Self.melbLocation
        manager.visitedRestaurants = visitedRestaurants
        return manager
    }()
    
    // MARK: - Test Cases -
    
    @Test("Location manager provides current location")
    func getCurrentLocation() async throws {
        #expect(locationManager.currentLocation == Self.melbLocation)
    }
    
    @Test("Nearby restaurants are within the nearby distance.")
    func nearByRestaurantsWithinDistance() throws {
        guard let currentLocation = locationManager.currentLocation else {
            #warning("No location")
            return
        }
        for restaurant in locationManager.nearByRestaurants {
            print(restaurant.name, restaurant.location.distance(from: currentLocation))
            let restaurantDistace = restaurant.location.distance(from: currentLocation)
            #expect(restaurantDistace <= locationManager.nearByDistance)
        }
    }
}
