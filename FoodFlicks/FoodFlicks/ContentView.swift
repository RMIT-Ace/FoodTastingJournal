//
//  ContentView.swift
//  FoodFlicks
//
//  Created by Ace on 8/5/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NearbyView()
                .tabItem {
                    Label("Nearby", systemImage: "location")
                }

            RestaurantListView()
                .tabItem {
                    Label("Restaurants", systemImage: "fork.knife.circle")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    ContentView()
}
