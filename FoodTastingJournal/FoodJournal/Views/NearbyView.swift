//
//  NearbyView.swift
//  FoodFlicks
//
//  Created by Ace on 8/5/2026.
//

import SwiftUI
import MapKit

struct NearbyView: View {
    @Environment(LocationManager.self) private var locationManager
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                if let currentLocation = locationManager.currentLocation {
                    Annotation("Current Location", coordinate: currentLocation.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundStyle(.red)
                            .accessibilityIdentifier("CurrentLocationPin")
                    }
                }
            }
            .accessibilityIdentifier("NearbyMap")
            .navigationTitle("Nearby")
            .task {
                await locationManager.startUpdatingCurrentLocation()
            }
            .onChange(of: locationManager.currentLocation, initial: true) {
                guard let currentLocation = locationManager.currentLocation else { return }
                setCameraPosition(to: currentLocation)
            }
        }
    }
    
    private func setCameraPosition(
        to location: CLLocation,
        radius: CLLocationDistance = 1000
    ) {
        cameraPosition = .region(
            MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: radius,
                longitudinalMeters: radius
            )
        )
    }
}

#Preview {
    NearbyView()
        .environment(LocationManager())
}
