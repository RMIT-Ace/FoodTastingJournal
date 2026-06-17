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
    
    enum TestError: Error {
        case testTimeoutError
    }
    
    private func waitFor<T>(
        timeout: Duration = .seconds(15),
        poll: Duration = .milliseconds(50),
        condition: () -> T?
    ) async throws -> T {
        let deadline = ContinuousClock.now + timeout
        while ContinuousClock.now < deadline {
            if let value = condition() { return value }
            try await Task.sleep(for: poll)
        }
        throw TestError.testTimeoutError
    }
    
    @Test("Location manager provides location")
    @MainActor
    func locationManagerWorks() async throws {
        let locationManager = LocationManager()
        #expect(locationManager.authorizationStatus == .authorizedWhenInUse)
        
        let currentLocation = try await waitFor { locationManager.currentLocation }
        print(">> current location updated: \(currentLocation)")
        #expect(locationManager.currentLocation != nil)
    }
    
    @Test("All recorded restaurants calculated with distances from a given location.")
    func allRestaurantsWithDistances() throws {
        Issue.record("To be implemented")
    }
}
