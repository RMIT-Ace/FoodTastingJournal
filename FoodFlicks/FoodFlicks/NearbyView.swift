//
//  NearbyView.swift
//  FoodFlicks
//
//  Created by Ace on 8/5/2026.
//

import MapKit
import SwiftUI

struct NearbyView: View {
    @State private var locationManager = LocationManager()
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)

    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .onAppear {
            locationManager.requestAuthorization()
        }
    }
}

#Preview {
    NearbyView()
}
