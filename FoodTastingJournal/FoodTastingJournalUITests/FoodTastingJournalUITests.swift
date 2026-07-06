//
//  FoodTastingJournalUITests.swift
//  FoodTastingJournalUITests
//
//  Created by Ace on 30/6/2026.
//

import XCTest

final class FoodTastingJournalUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // XCUIAutomation Documentation
        // https://developer.apple.com/documentation/xcuiautomation
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

    /// TDD: Verifies that a map view is displayed in `NearbyView`.
    /// Implementation note:
    /// - Attach `.accessibilityIdentifier("NearbyMap")` to the `Map` in NearbyView.
    @MainActor
    func testNearbyViewShowsMap() throws {
        let app = XCUIApplication()
        app.launch()

        // Look for the map element by its accessibility identifier.
        let mapMarker = app.maps["NearbyMap"]

        // Allow a short wait for the map to appear.
        let exists = mapMarker.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Expected to find a map in NearbyView, but it was not present. Make sure the Map in NearbyView has accessibilityIdentifier 'NearbyMap'.")
    }
}
