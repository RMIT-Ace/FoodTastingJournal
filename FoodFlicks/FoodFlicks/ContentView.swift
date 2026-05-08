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
                    Label("Nearby", systemImage: "swift")
                }

            RestaurantListView()
                .tabItem {
                    Label("Restaurants", systemImage: "list.bullet")
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
