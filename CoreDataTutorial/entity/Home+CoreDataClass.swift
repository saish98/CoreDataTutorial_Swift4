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
    
    let request: NSFetchRequest<Home> = Home.fetchRequest()
    typealias HomesByStatusHandler = (_ homes: [Home]) -> Void
    
//    func getHomeByStatus(isForSale: Bool, moc: NSManagedObjectContext) -> [Home] {
//        let request:NSFetchRequest<Home> = Home.fetchRequest()
//        //IMP predicate with bool
//        request.predicate = NSPredicate(format: "isForSale = %@", NSNumber(value: isForSale))
//        do {
//         let homes = try moc.fetch(request)
//            return homes
//        }
//        catch {
//            fatalError("Error in getting list of homes")
//        }
//    }
    
    func getHomesByStatus(request: NSFetchRequest<Home>, moc: NSManagedObjectContext, completionHandler: @escaping HomesByStatusHandler) {
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { (results: NSAsynchronousFetchResult<Home>) in
            let homes = results.finalResult!
            completionHandler(homes)
        }
        do {
            try moc.execute(asyncRequest)
        }
        catch {
            fatalError("Error in getting list of homes")
        }
    }
}
