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
            List {
                Text("Restaurant A")
                Text("Restaurant B")
                Text("Restaurant C")
                Text("Restaurant D")
                Text("Restaurant E")
            }
            .navigationTitle("Restaurants")
        }
    }
}

#Preview {
    RestaurantListView()
}
