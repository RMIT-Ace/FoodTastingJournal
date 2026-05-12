//
//  Restaurants.swift
//  FoodFlicks
//
//  Created by Ace on 9/5/2026.
//

import Foundation

enum CuisineType: String, CaseIterable, Identifiable {
    case italian, japanese, mexican, american
    var id: String { rawValue }
}

struct Restaurant: Identifiable {
    var id: String { name }
    var name: String
    var type: CuisineType
}

let restaurants: [Restaurant] = [
    Restaurant(name: "Pizzeria Margherita", type: .italian),
    Restaurant(name: "Sushi Central", type: .japanese),
    Restaurant(name: "Tacos El Rey", type: .mexican),
    Restaurant(name: "Burger Bonanza", type: .american),
    Restaurant(name: "Poke Palace", type: .japanese),
]
