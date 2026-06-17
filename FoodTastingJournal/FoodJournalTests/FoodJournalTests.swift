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
    
    // MARK: - Test Cases -
    
    static let alwaysFailed: Bool = 1 == 2
    
    @Test("Location manager provides current location")
    func getCurrentLocation() async throws {
        Issue.record("No test implemented")
    }
    
    @Test("Nearby restaurants are within the nearby distance.")
    func nearByRestaurantsWithinDistance() throws {
        #expect(Self.alwaysFailed, "To be implemented")
    }
}
