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
    let soldPredicate:NSPredicate = NSPredicate(format: "isForSale = false")
    
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
    
    func getTotalHomeSales(moc: NSManagedObjectContext) -> String {
        request.predicate = soldPredicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = "totalSales"
        sumExpressionDescription.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        do {
            let results = try moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            let dictionary = results.first!
            let totalSales = dictionary["totalSales"] as! Double
            
            return totalSales.currencyFormatter
        }
        catch {
            fatalError("Error getting total home sales")
        }
    }
    
   func getHomePriceSold(priceType: String, moc: NSManagedObjectContext) -> String {
        request.predicate = soldPredicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = priceType
        sumExpressionDescription.expression = NSExpression(forFunction: "\(priceType):", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        do {
            let results = try moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            let dictionary = results.first!
            let homePrice = dictionary[priceType] as! Double
            
            
            return homePrice.currencyFormatter
        }
        catch {
            fatalError("Error getting \(priceType) home sales")
        }
    }
    
    func getAverageHomePrice(homeType: String, moc: NSManagedObjectContext) -> String {
        let typePredicate = NSPredicate(format: "homeType = %@", homeType)
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [soldPredicate, typePredicate])
        
        request.predicate = predicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = homeType
        sumExpressionDescription.expression = NSExpression(forFunction: "average:", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        do {
            let results = try moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            let dictionary = results.first!
            let homePrice = dictionary[homeType] as! Double
            
            return homePrice.currencyFormatter
        }
        catch {
            fatalError("Error getting average \(homeType) price")
        }
    }
    
    func getNumberCondoSold(moc: NSManagedObjectContext) -> String {
        let typePredicate = NSPredicate(format: "homeType = 'Condo'")
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [soldPredicate, typePredicate])
        
        request.resultType = .countResultType
        request.predicate = predicate
        
        var count: NSNumber!
        do {
            let results = try moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSNumber]
            count = results.first
        }
        catch {
            fatalError("Error counting condo sold")
        }
        
        return count.stringValue
    }
    
    func getNumberSingleFamilyHomeSold(moc: NSManagedObjectContext) -> String {
        let typePredicate = NSPredicate(format: "homeType = 'Single Family'")
        let predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [soldPredicate, typePredicate])
        
        request.predicate = predicate
        
        do {
            let count = try moc.count(for: request)
            
            if count != NSNotFound {
                return String(count)
            }
            else {
                fatalError("Error counting single family home sold")
            }
        }
        catch {
            fatalError("Error counting single family home sold")
        }
    }
}
