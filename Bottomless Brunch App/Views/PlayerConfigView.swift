import SwiftUI
import CoreData

struct PlayerConfigView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @State private var selectedTask: Tasks?
    @State private var player: Player
    @State private var isBreakdownExpanded: Bool = false
    @ObservedObject var tasksPenalties = TasksPenalities.shared


    @FetchRequest(
        entity: Tasks.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Tasks.name, ascending: true)]
    ) private var tasks: FetchedResults<Tasks>

    init(player: Player) {
        _player = State(initialValue: player)
    }

    var body: some View {
        NavigationView {
            Form {
                
                TaskSelectorView(player: player)
                PenaltySelectorView(player: player)
        
                Section(header: Text("Total Points")) {
                    VStack {
                        HStack {
                            Text("\(player.points) pts")
                                .font(.largeTitle)
                                .padding()
                        }

                        DisclosureGroup(isExpanded: $isBreakdownExpanded) {
                            VStack(alignment: .leading) {
                                // Compute sorted tasks
                                let sortedTasks = (player.taskRelation as? Set<Tasks> ?? [])
                                    .sorted { ($0.dateAdded ?? Date()) > ($1.dateAdded ?? Date()) }
                                
                                ForEach(sortedTasks, id: \.objectID) { task in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("\(task.name ?? "Unknown Task") - \(dateFormatter.string(from: task.dateAdded ?? Date()))") // Concatenate name and date
                                                .font(.body)
                                                .foregroundColor(.primary)
                                        }
                                        Spacer()
                                        Text("+\(task.points) pts")
                                            .foregroundColor(.green)

                                    }
                                }

                                // Compute sorted penalties
                                let sortedPenalties = (player.penaltyRelation as? Set<Penalties> ?? [])
                                    .sorted { ($0.dateAdded ?? Date()) > ($1.dateAdded ?? Date()) }
                                
                                ForEach(sortedPenalties, id: \.objectID) { penalty in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("\(penalty.name ?? "Unknown Penalty") - \(dateFormatter.string(from: penalty.dateAdded ?? Date()))") // Concatenate name and date
                                                .font(.body)
                                                .foregroundColor(.primary)
                                        }
                                        Spacer()
                                        Text("-\(penalty.points) pts")
                                            .foregroundColor(.red)

                                    }
                                }
                            }
                        } label: {
                            Text("Show Breakdown")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                }

                if player.drinkability != "Non-Drinker" {
                    // Finish Drink Section
                    Section(header: Text("Finish Drink Points")) {
                        HStack {
                            Button(action: {
                                if let finishDrinkTask = tasksPenalties.T_finishDrink {
                                    tasksPenalties.addTask(player: player, task: finishDrinkTask)
                                    saveContext()
                                }
                            }) {
                                Text("Finish Drink +1")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }

                    // Last Drink Section
                    Section(header: Text("Last Drink Penalty")) {
                        HStack {
                            Button(action: {
                                if let lastDrinkPenalty = tasksPenalties.P_lastDrink {
                                    tasksPenalties.addPenalty(player: player, penalty: lastDrinkPenalty)
                                    saveContext()
                                }
                            }) {
                                Text("Last to Drink -1")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }

                // Save Button Section
                Section {
                    Button(action: savePlayer) {
                        Text("Save")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle(player.name ?? "Player")
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }

    private func savePlayer() {
        guard !(player.name?.isEmpty ?? true) else {
            return
        }
        saveContext()
        dismiss()
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

}
