//
//  Tasks+CoreDataProperties.swift
//  Bottomless Brunch
//
//  Created by Joey on 28/08/2024.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var name: String?
    @NSManaged public var points: Int64
    @NSManaged public var dateAdded: Date?

}

extension Tasks : Identifiable {

}
