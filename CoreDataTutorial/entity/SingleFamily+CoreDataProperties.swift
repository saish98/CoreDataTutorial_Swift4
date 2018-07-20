//
//  SingleFamily+CoreDataProperties.swift
//  CoreDataTutorial
//
//  Created by Heady on 18/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//
//

import Foundation
import CoreData


extension SingleFamily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingleFamily> {
        return NSFetchRequest<SingleFamily>(entityName: "SingleFamily")
    }

    @NSManaged public var lotSize: Int16

}
