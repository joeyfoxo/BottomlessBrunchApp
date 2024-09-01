//
//  Player+CoreDataProperties.swift
//  Bottomless Brunch
//
//  Created by Joey on 28/08/2024.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var drinkability: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var penalties: [Penalties]?
    @NSManaged public var points: Int64
    @NSManaged public var tasks: [Tasks]?
    @NSManaged public var penaltyRelation: NSSet?
    @NSManaged public var taskRelation: NSSet?

}

// MARK: Generated accessors for penaltyRelation
extension Player {

    @objc(addPenaltyRelationObject:)
    @NSManaged public func addToPenaltyRelation(_ value: Penalties)

    @objc(removePenaltyRelationObject:)
    @NSManaged public func removeFromPenaltyRelation(_ value: Penalties)

    @objc(addPenaltyRelation:)
    @NSManaged public func addToPenaltyRelation(_ values: NSSet)

    @objc(removePenaltyRelation:)
    @NSManaged public func removeFromPenaltyRelation(_ values: NSSet)

}

// MARK: Generated accessors for taskRelation
extension Player {

    @objc(addTaskRelationObject:)
    @NSManaged public func addToTaskRelation(_ value: Tasks)

    @objc(removeTaskRelationObject:)
    @NSManaged public func removeFromTaskRelation(_ value: Tasks)

    @objc(addTaskRelation:)
    @NSManaged public func addToTaskRelation(_ values: NSSet)

    @objc(removeTaskRelation:)
    @NSManaged public func removeFromTaskRelation(_ values: NSSet)

}

extension Player : Identifiable {

}
