//
//  PlayerRowView.swift
//  Bottomless Brunch
//
//  Created by Joey on 24/08/2024.
//

import SwiftUI

struct PlayerRowView: View {
    
    @ObservedObject var tasksPenalties = TasksPenalities.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Player.name, ascending: true)],
        animation: .default)
    

    private var players: FetchedResults<Player>
    var body: some View {
        List {
            ForEach(players, id: \.self) { player in
                HStack {
                    // Only the text is wrapped in NavigationLink
                    NavigationLink(destination: PlayerConfigView(player: player)) {
                        VStack(alignment: .leading) {
                            Text(player.name ?? "Unknown")
                                .font(.headline)
                            Text("Drinkability: \(player.drinkability ?? "Unknown")")
                                .font(.subheadline)
                        }
                    }
                    .labelStyle(.iconOnly)
                    
                    
                    HStack(spacing: 15) {
                        Button(action: {
                            // Decrement points
                            tasksPenalties.addPenalty(player: player, penalty: tasksPenalties.P_lastDrink!)
                            saveContext()
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Display current points
                        Text("\(player.points) pts")
                            .font(.headline)
                        
                        
                        Button(action: {
                            // Increment points
                            tasksPenalties.addTask(player: player, task: tasksPenalties.T_finishDrink!)
                            saveContext()
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.green)
                        }
                        .buttonStyle(PlainButtonStyle()) // Prevents button from triggering NavigationLink
                    }
                }
                .contentShape(Rectangle()) // Defines a tappable area for the row, avoiding full row tap triggering
            }
            .onDelete(perform: deletePlayers)
        }
        .onAppear {
            updateData()
        }
    }
    
    private func deletePlayers(at offsets: IndexSet) {
        withAnimation {
            offsets.map { players[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("Failed to delete players: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
    
    private func updateData() {
        do {
            try viewContext.save()
        }
        catch {
            print("Couldn’t save")
        }
    }
    
}
