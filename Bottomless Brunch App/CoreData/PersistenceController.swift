import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DataModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
//        let storeURL = container.persistentStoreDescriptions.first?.url
//        try? FileManager.default.removeItem(at: storeURL!)
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                
                // Log or handle the error
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        }
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

    }
}
