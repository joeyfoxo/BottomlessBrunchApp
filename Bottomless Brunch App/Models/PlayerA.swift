//
//  User.swift
//  Bottomless Brunch App
//
//  Created by Joey on 22/08/2024.
//

import Foundation


struct Player: Identifiable {
    var id = UUID()
    var name: String
    var tasks: [Task] = []
    var penalties: [Penalty] = []
    var drinksCompleted: Int
    
    var totalPoints: Int {
        let taskPoints = tasks.reduce(0) { $0 + $1.points }
        let penaltyPoints = penalties.reduce(0) { $0 + $1.points }
        return taskPoints + penaltyPoints
    }

    mutating func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    mutating func addPenalty(_ penalty: Penalty) {
        penalties.append(penalty)
    }
    
    mutating func removeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
    
    mutating func removePenalty(_ penalty: Penalty) {
        if let index = penalties.firstIndex(where: { $0.id == penalty.id }) {
            penalties.remove(at: index)
        }
    }
}
