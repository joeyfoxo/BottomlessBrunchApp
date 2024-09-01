//
//  Tasks.swift
//  Bottomless Brunch App
//
//  Created by Joey on 22/08/2024.
//

import Foundation

struct Task: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var points: Int
}

struct TasksData {
    static let allTasks: [Task] = [
        Task(name: "Get served at spoons", points: 1),
        Task(name: "Swap a drink without other persons knowledge", points: 1),
        Task(name: "Solve the riddle", points: 2),
        Task(name: "Best Hat", points: 2),
        Task(name: "Steal Keele Card", points: 1),
        Task(name: "Steal someones hat", points: 1)
    ]
}
