//
//  SaleHistory+CoreDataClass.swift
//  CoreDataTutorial
//
//  Created by Heady on 18/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SaleHistory)
public class SaleHistory: NSManagedObject {

    func getSoldHistory(home: Home, moc: NSManagedObjectContext) -> [SaleHistory] {
        let soldHistoryRequest:NSFetchRequest<SaleHistory> = SaleHistory.fetchRequest()
        soldHistoryRequest.predicate = NSPredicate(format: "home = %@", home)
        
        do{
            let soldHistory = try moc.fetch(soldHistoryRequest)
            return soldHistory
        }
        catch {
            fatalError("Error in getting sold history")
        }
    }
}
