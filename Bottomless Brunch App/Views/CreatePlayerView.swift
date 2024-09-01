import SwiftUI
import CoreData

struct CreatePlayerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name: String = ""
    @State private var selectedDrinkability: String = "Lightweight"
    @State private var showAlert: Bool = false
    @Environment(\.dismiss) var dismiss // Access the dismiss environment value

    
    // Weight categories
    private let drinkability = ["Lightweight", "Normalweight", "Heavyweight", "Non-Drinker"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Player Details")) {
                    TextField("Enter player name", text: $name)
                    
                    Picker("Drinkability", selection: $selectedDrinkability) {
                        ForEach(drinkability, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Button(action: savePlayer) {
                    Text("Save")
                }
            }
            .navigationTitle("Create Player")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Please enter a name."), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func savePlayer() {
        guard !name.isEmpty else {
            showAlert = true
            return
        }

        let newPlayer = Player(context: viewContext)
        newPlayer.name = name
        newPlayer.drinkability = selectedDrinkability
        newPlayer.id = UUID.init()
        do {
            try viewContext.save()
            print("Player saved successfully")
            dismiss()
        } catch {
            // Handle the error appropriately
            print("Failed to save player: \(error)")
        }
    }
}
