//
//  Penalties+CoreDataProperties.swift
//  Bottomless Brunch
//
//  Created by Joey on 28/08/2024.
//
//

import Foundation
import CoreData


extension Penalties {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Penalties> {
        return NSFetchRequest<Penalties>(entityName: "Penalties")
    }

    @NSManaged public var name: String?
    @NSManaged public var points: Int64
    @NSManaged public var dateAdded: Date?

}

extension Penalties : Identifiable {

}
