//
//  NearbyView.swift
//  FoodFlicks
//
//  Created by Ace on 8/5/2026.
//

import SwiftUI
import MapKit

struct NearbyView: View {
    
    var body: some View {
        NavigationStack {
            Map()
                .accessibilityIdentifier("NearbyMap")
                .navigationTitle("Nearby")
        }
    }
}

#Preview {
    NearbyView()
}
