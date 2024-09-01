//
//  Challenges.swift
//  Bottomless Brunch App
//
//  Created by Joey on 22/08/2024.
//

import Foundation


struct Penalty: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var points: Int
}

struct PenaltyData {
    static let allPenalties: [Penalty] = [
        Penalty(name: "Chundering", points: 1),
        Penalty(name: "Arrive early or late", points: 1),
        Penalty(name: "Trip up", points: 1),
        Penalty(name: "Spillage", points: 1),
        Penalty(name: "Keele Card Stolen", points: 1),
        Penalty(name: "Not Doing drink", points: 2),
        Penalty(name: "Last to finish Drink", points: 1)
    ]
}
