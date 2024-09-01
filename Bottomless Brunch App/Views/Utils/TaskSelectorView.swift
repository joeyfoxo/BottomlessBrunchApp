import SwiftUI

struct TaskSelectorView: View {
    @ObservedObject var tasksPenalties = TasksPenalities.shared
    @State private var selectedTasks: Tasks?
    @State private var player: Player
    @State private var refreshId = UUID()  // Add a UUID to force refresh

    init(player: Player) {
        _player = State(initialValue: player)
    }

    var body: some View {
        Section(header: Text("Tasks")) {
            Picker("Select a Task", selection: $selectedTasks) {
                Text("Select a Task").tag(nil as Tasks?) // Placeholder
                ForEach(tasksPenalties.allTasks, id: \.self) { task in
                    Text("\(task.name ?? "") - \(task.points) pts")
                        .tag(task as Tasks?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedTasks) { newTask in
                if let task = newTask {
                    tasksPenalties.addTask(player: player, task: task)
                    selectedTasks = nil // Reset the selection to trigger a state update
                    refreshId = UUID()  // Force a view refresh
                }
            }

            let playerTasks = Array(player.taskRelation as? Set<Tasks> ?? [])
            ForEach(playerTasks, id: \.objectID) { task in
                HStack {
                    Text(task.name ?? "Unknown")
                    Spacer()
                    Text("+\(task.points) pts")
                        .foregroundColor(.green)
                    
                    // Delete button
                    Button(action: {
                        tasksPenalties.removeTask(task, from: player)
                        refreshId = UUID()  // Force a view refresh
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .id(refreshId)  // Attach the refreshId to force the view to update
    }
}
