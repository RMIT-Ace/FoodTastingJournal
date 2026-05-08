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
    @State private var hasZoomed = false

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
        .onChange(of: locationManager.userLocation) { _, newLocation in
            guard let location = newLocation, !hasZoomed else { return }
            hasZoomed = true
            let cityRegion = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 5000,
                longitudinalMeters: 5000
            )
            position = .region(cityRegion)
        }
    }
}

#Preview {
    NearbyView()
}
