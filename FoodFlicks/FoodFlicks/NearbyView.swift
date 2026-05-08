//
//  NearbyView.swift
//  FoodFlicks
//
//  Created by Ace on 8/5/2026.
//

import CoreLocation
import MapKit
import SwiftUI

struct NearbyView: View {
    @State private var coordinate: CLLocationCoordinate2D?

    var body: some View {
        Group {
            if let coordinate {
                NearbyMapView(coordinate: coordinate)
            } else {
                ProgressView("Finding your location…")
            }
        }
        .task {
            let manager = CLLocationManager()
            if manager.authorizationStatus == .notDetermined {
                manager.requestWhenInUseAuthorization()
            }
            do {
                for try await update in CLLocationUpdate.liveUpdates() {
                    if let location = update.location {
                        coordinate = location.coordinate
                        return
                    }
                }
            } catch {}
        }
    }
}

struct NearbyMapView: View {
    @State private var position: MapCameraPosition

    init(coordinate: CLLocationCoordinate2D) {
        _position = State(initialValue: .region(MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )))
    }

    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
    }
}

#Preview {
    NearbyView()
}
