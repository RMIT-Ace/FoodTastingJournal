//
//  RestaurantListView.swift
//  FoodFlicks
//
//  Created by Ace on 8/5/2026.
//

import SwiftUI

struct RestaurantListView: View {
    var body: some View {
        NavigationStack {
            List(restaurants) { restaurant in
                HStack {
                    Text(restaurant.name)
                    Spacer()
                    Text(restaurant.type.rawValue)
                }
            }
            .navigationTitle("Restaurants")
        }
    }
}

#Preview {
    RestaurantListView()
}
