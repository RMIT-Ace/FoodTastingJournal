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
        // Use an any-type query because SwiftUI may not expose Map as XCUIElementType.map.
        let mapMarker = app.descendants(matching: .any)["NearbyMap"].firstMatch

        // Allow a short wait for the map to appear.
        let exists = mapMarker.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Expected to find a map in NearbyView, but it was not present. Make sure the Map in NearbyView has accessibilityIdentifier 'NearbyMap'.")
    }

    /// TDD: Verifies that the map in `NearbyView` shows a pin at the current location.
    /// Implementation note:
    /// - Add an annotation for the current location to the Map in NearbyView, and attach
    ///   `.accessibilityIdentifier("CurrentLocationPin")` to its content view.
    @MainActor
    func testNearbyMapShowsCurrentLocationPin() throws {
        let app = XCUIApplication()
        app.launch()

        // The pin must be inside the map.
        let mapMarker = app.descendants(matching: .any)["NearbyMap"].firstMatch
        XCTAssertTrue(mapMarker.waitForExistence(timeout: 5), "Expected to find the map in NearbyView before checking for the pin.")

        // Look for the current-location pin by its accessibility identifier.
        let currentLocationPin = mapMarker.descendants(matching: .any)["CurrentLocationPin"].firstMatch

        // Allow a short wait for the pin to appear on the map.
        let exists = currentLocationPin.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Expected to find a pin for the current location on the map, but it was not present. Make sure the current-location annotation has accessibilityIdentifier 'CurrentLocationPin'.")
    }
}
