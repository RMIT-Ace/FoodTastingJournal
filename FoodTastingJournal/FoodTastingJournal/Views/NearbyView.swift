//
//  NearbyView.swift
//  FoodFlicks
//
//  Created by Ace on 8/5/2026.
//

import SwiftUI
import MapKit

struct NearbyView: View {
    @State private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $cameraPosition) {
                    // Show user's current location
                    if let location = locationManager.currentLocation {
                        Annotation("You are here", coordinate: CLLocationCoordinate2D(
                            latitude: location.latitude,
                            longitude: location.longitude
                        )) {
                            ZStack {
                                Circle()
                                    .fill(.blue.opacity(0.3))
                                    .frame(width: 40, height: 40)
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 16, height: 16)
                            }
                        }
                    }
                    
                    // Add UserAnnotation for native current location indicator
                    UserAnnotation()
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
                .mapStyle(.standard(elevation: .realistic))
                
                // Overlay for location status
                if locationManager.authorizationStatus == .notDetermined {
                    VStack {
                        Spacer()
                        Button("Enable Location Services") {
                            locationManager.requestAuthorization()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                    }
                } else if locationManager.authorizationStatus == .denied || 
                          locationManager.authorizationStatus == .restricted {
                    VStack {
                        Spacer()
                        VStack(spacing: 12) {
                            Image(systemName: "location.slash")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                            Text("Location Access Needed")
                                .font(.headline)
                            Text("Please enable location access in Settings to see nearby restaurants.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                            Button("Open Settings") {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(url)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                    }
                }
            }
            .onAppear {
                locationManager.requestLocation()
                updateCameraPosition()
            }
            .onChange(of: locationManager.currentLocation) { oldValue, newValue in
                updateCameraPosition()
            }
        }
    }
    
    private func updateCameraPosition() {
        if let location = locationManager.currentLocation {
            cameraPosition = .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: location.latitude,
                    longitude: location.longitude
                ),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        }
    }
}

#Preview {
    NearbyView()
}
