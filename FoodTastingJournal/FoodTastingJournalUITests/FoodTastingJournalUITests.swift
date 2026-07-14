//
//  FoodTastingJournalUITests.swift
//  FoodTastingJournalUITests
//
//  Created by Ace on 30/6/2026.
//

import XCTest

final class FoodTastingJournalUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    /// TDD: Verifies that the app launches into `NearbyView`.
    /// Implementation note:
    /// - Ensure the root view (or a unique element in NearbyView) has accessibilityIdentifier set to "NearbyView".
    ///   For SwiftUI, you can attach `.accessibilityIdentifier("NearbyView")` to a container in NearbyView.
    @MainActor
    func testLaunchShowsNearbyView() throws {
        let app = XCUIApplication()
        app.launch()

        // Look for a uniquely identifiable element that belongs to NearbyView.
        // Prefer an accessibility identifier for robustness.
        let nearbyViewMarker = app.otherElements["NearbyView"]

        // Allow a short wait for the initial view to appear.
        let exists = nearbyViewMarker.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Expected to find NearbyView on launch, but it was not present. Make sure an element in NearbyView has accessibilityIdentifier 'NearbyView'.")
    }
}
