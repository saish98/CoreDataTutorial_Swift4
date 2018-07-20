//
//  Condo+CoreDataProperties.swift
//  CoreDataTutorial
//
//  Created by Heady on 18/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//
//

import Foundation
import CoreData


extension Condo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Condo> {
        return NSFetchRequest<Condo>(entityName: "Condo")
    }

    @NSManaged public var unitsPerBuilding: Int16

}
