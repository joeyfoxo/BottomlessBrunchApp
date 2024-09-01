import SwiftUI

struct PlayerView: View {
    
    @StateObject var viewModel = PlayerViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Player.points, ascending: false)], // Sort by points in descending order
        animation: .default)
    private var players: FetchedResults<Player>
    @ObservedObject var tasksPenalties = TasksPenalities.shared
    
    // State to control showing the confirmation alerts
    @State private var showAddPointConfirmation = false
    @State private var showSubtractPointConfirmation = false
    
    
    var body: some View {
        TabView {
            // Player List Tab
            NavigationView {
                VStack {
                    PlayerRowView()
                    
                    HStack {
                        // +1 Button
                        Button(action: {
                            showAddPointConfirmation = true
                        }) {
                            Text("Completed Drink +1")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                        .alert(isPresented: $showAddPointConfirmation) {
                            Alert(
                                title: Text("Confirm Action"),
                                message: Text("Are you sure you want to add 1 point to all players?"),
                                primaryButton: .destructive(Text("Add 1 Point")) {
                                    addPointToAllPlayers()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                        
                        // -1 Button
                        Button(action: {
                            showSubtractPointConfirmation = true
                        }) {
                            Text("Last to Drink/minus -1")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                        .alert(isPresented: $showSubtractPointConfirmation) {
                            Alert(
                                title: Text("Confirm Action"),
                                message: Text("Are you sure you want to subtract 1 point from all players?"),
                                primaryButton: .destructive(Text("Minus 1 Point")) {
                                    subtractPointFromAllPlayers()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                }
                .navigationTitle("Players")
                .toolbar {
                    Button {
                        viewModel.showingPlayerView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $viewModel.showingPlayerView) {
                    CreatePlayerView()
                }
            }
            .tabItem {
                Label("Players", systemImage: "person.3")
            }
            
            // Leaderboard Tab
            LeaderboardView()
                .tabItem {
                    Label("Leaderboard", systemImage: "list.number")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func addPointToAllPlayers() {
        for player in players {
            if (player.drinkability != "Non-Drinker") {
                // Create a new task for "Completed Drink"
                
                tasksPenalties.addTask(player: player, task: tasksPenalties.T_finishDrink!)
            }
        }
        saveContext()
    }
    
    private func subtractPointFromAllPlayers() {
        for player in players {

            tasksPenalties.addPenalty(player: player, penalty: tasksPenalties.P_lastDrink!)
            
        }
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
