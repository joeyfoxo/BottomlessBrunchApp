import Foundation
import CoreData

class TasksPenalities : ObservableObject {
    
    static let shared = TasksPenalities()
    
    let persistenceController = PersistenceController.shared
    
    // Define penalties and tasks as properties
    var P_chunder: Penalties?
    var P_earlyLate: Penalties?
    var P_falling: Penalties?
    var P_spillage: Penalties?
    var P_stolenCard: Penalties?
    var P_mandatoryTaskNotMet: Penalties?
    var P_notDoingDrink: Penalties?
    var P_arguing: Penalties?
    var P_cheating: Penalties?
    var P_hatRemoval: Penalties?
    @Published var P_lastDrink: Penalties?
    
    var T_getServed: Tasks?
    var T_swapDrinks: Tasks?
    var T_solveRiddle: Tasks?
    var T_bestHat: Tasks?
    var T_findAntagoniseStudent: Tasks?
    var T_firstToSpoons: Tasks?
    var T_unusualItem: Tasks?
    var T_dressLikeAFool: Tasks?
    var T_worstIDPhoto: Tasks?
    var T_stealCard: Tasks?
    var T_stealHat: Tasks?
    var T_singHappyBirthday: Tasks?
    var T_findKevin: Tasks?
    @Published var T_finishDrink: Tasks?
    
    @Published var allTasks: [Tasks] = []
    @Published var allPenalties: [Penalties] = []
    
    private init() {
        // Initialize the data when the class is instantiated
        initData(context: persistenceController.container.viewContext)
    }
    
    private func initData(context: NSManagedObjectContext) {
        
        let penaltyGetCaughtChundering = Penalties(context: context)
        penaltyGetCaughtChundering.name = "Get caught chundering"
        penaltyGetCaughtChundering.points = 1
        self.P_chunder = penaltyGetCaughtChundering
        allPenalties.append(penaltyGetCaughtChundering)
        
        let penaltyArriveEarlyLate = Penalties(context: context)
        penaltyArriveEarlyLate.name = "Arrive on time early or late"
        penaltyArriveEarlyLate.points = 1
        self.P_earlyLate = penaltyArriveEarlyLate
        allPenalties.append(penaltyArriveEarlyLate)
        
        let penaltyTripUp = Penalties(context: context)
        penaltyTripUp.name = "Trip up"
        penaltyTripUp.points = 1
        self.P_falling = penaltyTripUp
        allPenalties.append(penaltyTripUp)
        
        let penaltySpillDrink = Penalties(context: context)
        penaltySpillDrink.name = "Spill drink/spillage"
        penaltySpillDrink.points = 1
        self.P_spillage = penaltySpillDrink
        allPenalties.append(penaltySpillDrink)
        
        let penaltyCardStolen = Penalties(context: context)
        penaltyCardStolen.name = "Get Keele card stolen"
        penaltyCardStolen.points = 1
        self.P_stolenCard = penaltyCardStolen
        allPenalties.append(penaltyCardStolen)
        
        let penaltyMandatoryTaskNotMet = Penalties(context: context)
        penaltyMandatoryTaskNotMet.name = "Not doing mandatory task"
        penaltyMandatoryTaskNotMet.points = 2
        self.P_mandatoryTaskNotMet = penaltyMandatoryTaskNotMet
        allPenalties.append(penaltyMandatoryTaskNotMet)
        
        let penaltyNotDoingDrink = Penalties(context: context)
        penaltyNotDoingDrink.name = "Not doing/missing a drink"
        penaltyNotDoingDrink.points = 2
        self.P_notDoingDrink = penaltyNotDoingDrink
        allPenalties.append(penaltyNotDoingDrink)
        
        let penaltyLastToDrink = Penalties(context: context)
        penaltyLastToDrink.name = "Last to drink"
        penaltyLastToDrink.points = 1
        self.P_lastDrink = penaltyLastToDrink
        allPenalties.append(penaltyLastToDrink)
        
        let penaltyArguing = Penalties(context: context)
        penaltyArguing.name = "Arguing"
        penaltyArguing.points = 1
        self.P_arguing = penaltyArguing
        allPenalties.append(penaltyArguing)
        
        let penaltyCheating = Penalties(context: context)
        penaltyCheating.name = "Cheating"
        penaltyCheating.points = 1
        self.P_cheating = penaltyCheating
        allPenalties.append(penaltyCheating)
        
        let penaltyHatRemoval = Penalties(context: context)
        penaltyHatRemoval.name = "Removing your hat"
        penaltyHatRemoval.points = 3
        self.P_hatRemoval = penaltyHatRemoval
        allPenalties.append(penaltyHatRemoval)
        
        
        
        // Initialize Tasks
        let taskGetServed = Tasks(context: context)
        taskGetServed.name = "Get served at spoons"
        taskGetServed.points = 1
        self.T_getServed = taskGetServed
        allTasks.append(taskGetServed)
        
        let taskSwapDrinks = Tasks(context: context)
        taskSwapDrinks.name = "Swap a drink"
        taskSwapDrinks.points = 1
        self.T_swapDrinks = taskSwapDrinks
        allTasks.append(taskSwapDrinks)
        
        let taskSolveRiddle = Tasks(context: context)
        taskSolveRiddle.name = "Solve the riddle"
        taskSolveRiddle.points = 2
        self.T_solveRiddle = taskSolveRiddle
        allTasks.append(taskSolveRiddle)
        
        let taskBestHat = Tasks(context: context)
        taskBestHat.name = "Best Hat"
        taskBestHat.points = 2
        self.T_bestHat = taskBestHat
        allTasks.append(taskBestHat)
        
        let taskFindAntagoniseStudent = Tasks(context: context)
        taskFindAntagoniseStudent.name = "Antagonise a staffs student"
        taskFindAntagoniseStudent.points = 5
        self.T_findAntagoniseStudent = taskFindAntagoniseStudent
        allTasks.append(taskFindAntagoniseStudent)
        
        let taskFirstToSpoons = Tasks(context: context)
        taskFirstToSpoons.name = "First to spoons wins"
        taskFirstToSpoons.points = 1
        self.T_firstToSpoons = taskFirstToSpoons
        allTasks.append(taskFirstToSpoons)
        
        let taskUnusualItem = Tasks(context: context)
        taskUnusualItem.name = "Bring an unusual item"
        taskUnusualItem.points = 2
        self.T_unusualItem = taskUnusualItem
        allTasks.append(taskUnusualItem)
        
        let taskDressLikeAFool = Tasks(context: context)
        taskDressLikeAFool.name = "Worst outfit"
        taskDressLikeAFool.points = 3
        self.T_dressLikeAFool = taskDressLikeAFool
        allTasks.append(taskDressLikeAFool)
        
        let taskWorstIDPhoto = Tasks(context: context)
        taskWorstIDPhoto.name = "Worst ID photo"
        taskWorstIDPhoto.points = 1
        self.T_worstIDPhoto = taskWorstIDPhoto
        allTasks.append(taskWorstIDPhoto)
        
        let taskStealCard = Tasks(context: context)
        taskStealCard.name = "Steal the Keele card or ID"
        taskStealCard.points = 1
        self.T_stealCard = taskStealCard
        allTasks.append(taskStealCard)
        
        let taskStealHat = Tasks(context: context)
        taskStealHat.name = "Steal someone's hat"
        taskStealHat.points = 1
        self.T_stealHat = taskStealHat
        allTasks.append(taskStealHat)
        
        let taskFindKevin = Tasks(context: context)
        taskFindKevin.name = "Find someone with the name Kevin"
        taskFindKevin.points = 2
        self.T_findKevin = taskFindKevin
        allTasks.append(taskFindKevin)
        
        let finishDrink = Tasks(context: context)
        finishDrink.name = "Finish Drink"
        finishDrink.points = 1
        self.T_finishDrink = finishDrink
        allTasks.append(finishDrink)
        
        // Save context
        saveContext()
        print("Core Data initialized with default data.")
        
    }
    
    
    public func addTask(player: Player, task: Tasks) {
        let context = PersistenceController.shared.container.viewContext
        let newTask = Tasks(context: context)
        newTask.name = task.name
        newTask.points = task.points
        newTask.dateAdded = Date() // Set the dateAdded to current date and time
        
        player.addToTaskRelation(newTask)
        player.points += newTask.points
        
        saveContext()
    }
    
    public func addPenalty(player: Player, penalty: Penalties) {
        let context = PersistenceController.shared.container.viewContext
        let newPenalty = Penalties(context: context)
        newPenalty.name = penalty.name
        newPenalty.points = penalty.points
        newPenalty.dateAdded = Date() // Set the dateAdded to current date and time
        
        player.addToPenaltyRelation(newPenalty)
        player.points -= newPenalty.points
        
        saveContext()
    }
    
    public func removeTask(_ task: Tasks, from player: Player) {
        let context = PersistenceController.shared.container.viewContext
        
        player.removeFromTaskRelation(task)
        player.points -= task.points
        context.delete(task)
        saveContext()
        
    }
    
    public func removePenalty(_ penalty: Penalties, from player: Player) {
        let context = PersistenceController.shared.container.viewContext
        
        player.removeFromPenaltyRelation(penalty)
        player.points += penalty.points
        context.delete(penalty)
        saveContext()
        
    }
    
    private func saveContext() {
        do {
            try PersistenceController.shared.container.viewContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
