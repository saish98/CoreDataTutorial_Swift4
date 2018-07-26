//
//  AppDelegate.swift
//  CoreDataTutorial
//
//  Created by Heady on 18/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coreData = CoreDataStack()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        deleteRecord()
        checkDataStore()

        let managedObjectContext = coreData.persistentContainer.viewContext
        let tabBarController = self.window?.rootViewController as! UITabBarController
        
        //First Tab
        let homeListNavigationVC = tabBarController.viewControllers![0] as! UINavigationController
        let homeListVC = homeListNavigationVC.topViewController as! HomeViewController
        homeListVC.managedObjectContext = managedObjectContext
        
        // Second Tab - Summary View
        let summaryNavigationController = tabBarController.viewControllers?[1] as! UINavigationController
        let summaryViewController = summaryNavigationController.topViewController as! SummaryTableViewController
        summaryViewController.managedObjectContext = managedObjectContext
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        coreData.saveContext()
    }
    
    func checkDataStore() {
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        
        let moc = coreData.persistentContainer.viewContext
        do{
            let homeCount = try moc.count(for: request)
            if homeCount == 0 {
                uploadSampleData()
            }
        }
        catch {
            fatalError("Error in counting record")
        }
    }
    
    func uploadSampleData() {
        let url = Bundle.main.url(forResource: "homes", withExtension: "json")
        let data = try? Data(contentsOf: url!)
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            let jsonArray = jsonResult.value(forKey: "home") as! NSArray
            
//            let address = try JSONDecoder().decode(Address.self, from:response.data!)
            saveData(array: jsonArray)
        }
        catch {
            fatalError("Cannot upload sample data")
        }
    }
    
    func saveData(array:NSArray) {
        let moc = coreData.persistentContainer.viewContext
        for obj in array {
            let homeData = obj as! [String:AnyObject]
            
            guard let city = homeData["city"] else {
                return
            }
            
            guard let price = homeData["price"] else {
                return
            }
            
            guard let bed = homeData["bed"] else {
                return
            }
            
            guard let bath = homeData["bath"] else {
                return
            }
            
            guard let sqft = homeData["sqft"] else {
                return
            }
            
            guard let currentImage = homeData["image"] else {
                return
            }
            var image = UIImage(named: currentImage as! String)
            
            guard let homeCategory = homeData["category"] else {
                return
            }
            let homeType = (homeCategory as! NSDictionary)["homeType"] as? String
            
            guard let homeStatus = homeData["status"] else {
                return
            }
            let isForSale = (homeStatus as! NSDictionary)["isForSale"] as? Bool
            
            let home = homeType?.caseInsensitiveCompare("condo") == .orderedSame ? Condo(context: moc) : SingleFamily(context: moc)
            home.city = city as! String
            home.price = price as! Double
            home.bed = bed.int16Value
            home.bath = bath.int16Value
            home.sqft = sqft.int16Value
            home.image = NSData.init(data: UIImageJPEGRepresentation(image!, 1)!)
            home.homeType = homeType
            home.isForSale = isForSale!
            
            if let unitsPerBuilding = homeData["unitsPerBuilding"] {
                (home as! Condo).unitsPerBuilding = unitsPerBuilding.int16Value
            }
            
            if let lotSize = homeData["lotSize"] {
                (home as! SingleFamily).lotSize = lotSize.int16Value
            }
            
            if let saleHistoryArray = homeData["saleHistory"] {
                let saleHistoryData = home.saleHistory?.mutableCopy() as! NSMutableSet
                
                for obj in saleHistoryArray as! NSArray{
                    let saleDict = obj as! [String:AnyObject]
                    
                    let saleHistory = SaleHistory(context: moc)
                
                    saleHistory.soldPrice = saleDict["soldPrice"] as! Double
                
                    let soldDateString = saleDict["soldDate"] as! String
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from: soldDateString)
                    saleHistory.soldDate = date
                    // save sale history
                    
                    saleHistoryData.add(saleHistory)
                    home.addToSaleHistory(saleHistoryData)
                }
            }
        }
        coreData.saveContext()
    }
    
    func deleteRecord() {
        let moc = coreData.persistentContainer.viewContext
        
        let homeRequest:NSFetchRequest<Home> = Home.fetchRequest()
        let saleHistoryRequest:NSFetchRequest<SaleHistory> = SaleHistory.fetchRequest()
      
        var deleteRequest:NSBatchDeleteRequest
        var deleteResult:NSPersistentStoreResult

        do{
            deleteRequest = NSBatchDeleteRequest(fetchRequest: homeRequest as! NSFetchRequest<NSFetchRequestResult>)
            deleteResult = try moc.execute(deleteRequest)
            
            deleteRequest = NSBatchDeleteRequest(fetchRequest: saleHistoryRequest as! NSFetchRequest<NSFetchRequestResult>)
            deleteResult = try moc.execute(deleteRequest)
        }
        catch {
            fatalError("Failed removing existing records")
        }
    }
}

