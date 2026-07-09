//
//  FoodFlicksApp.swift
//  FoodFlicks
//
//  Created by Ace on 8/5/2026.
//

import SwiftUI

@main
struct FoodJournalApp: App {
    
    let locationManager: LocationManager
    
    init() {
        locationManager = LocationManager()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(locationManager)
    }
    
}

