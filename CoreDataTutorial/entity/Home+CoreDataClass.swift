//
//  Home+CoreDataClass.swift
//  CoreDataTutorial
//
//  Created by Heady on 18/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Home)
public class Home: NSManagedObject {
    func getHomeByStatus(isForSale: Bool, moc: NSManagedObjectContext) -> [Home] {
        let request:NSFetchRequest<Home> = Home.fetchRequest()
        //IMP predicate with bool
        request.predicate = NSPredicate(format: "isForSale = %@", NSNumber(value: isForSale))
        do {
         let homes = try moc.fetch(request)
            return homes
        }
        catch {
            fatalError("Error in getting list of homes")
        }
    }
}
