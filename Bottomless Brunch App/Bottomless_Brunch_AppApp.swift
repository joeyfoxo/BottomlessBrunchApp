//
//  Bottomless_Brunch_AppApp.swift
//  Bottomless Brunch App
//
//  Created by Joey on 22/08/2024.
//

import SwiftUI
import CoreData

@main
struct Bottomless_Brunch_AppApp: App {
    
    let persistenceController = PersistenceController.shared
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
        
    }

}
