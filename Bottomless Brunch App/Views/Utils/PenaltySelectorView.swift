import SwiftUI

struct PenaltySelectorView: View {
    @ObservedObject var tasksPenalties = TasksPenalities.shared
    @State private var selectedPenalty: Penalties?
    @State private var player: Player
    @State private var refreshId = UUID()  // Add a UUID to force refresh

    init(player: Player) {
        _player = State(initialValue: player)
    }

    var body: some View {
        Section(header: Text("Penalties")) {
            Picker("Select a Penalty", selection: $selectedPenalty) {
                Text("Select a Penalty").tag(nil as Penalties?) // Placeholder
                ForEach(tasksPenalties.allPenalties, id: \.self) { penalty in
                    Text("\(penalty.name ?? "") - \(penalty.points) pts")
                        .tag(penalty as Penalties?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedPenalty) { newPenalty in
                if let penalty = newPenalty {
                    tasksPenalties.addPenalty(player: player, penalty: penalty)
                    selectedPenalty = nil // Reset the selection to trigger a state update
                    refreshId = UUID()  // Force a view refresh
                }
            }

            let playerPenalties = Array(player.penaltyRelation as? Set<Penalties> ?? [])
            ForEach(playerPenalties, id: \.objectID) { penalty in
                HStack {
                    Text(penalty.name ?? "Unknown")
                    Spacer()
                    Text("-\(penalty.points) pts")
                        .foregroundColor(.red)
                    
                    // Delete button
                    Button(action: {
                        tasksPenalties.removePenalty(penalty, from: player)
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
