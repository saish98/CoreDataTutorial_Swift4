//
//  SummaryTableViewController.swift
//  CoreDataTutorial
//
//  Created by Heady on 26/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
import CoreData

class SummaryTableViewController: UITableViewController {

    @IBOutlet weak var totalSalesDollarLabel: UILabel!
    @IBOutlet weak var numCondoSoldLabel: UILabel!
    @IBOutlet weak var numSFSoldLabel: UILabel!
    @IBOutlet weak var minPriceHomeLabel: UILabel!
    @IBOutlet weak var maxPriceHomeLabel: UILabel!
    @IBOutlet weak var avgPriceCondoLabel: UILabel!
    @IBOutlet weak var avgPriceSFLabel: UILabel!
    
    // MARK: Properties
    var home: Home? = nil
    weak var managedObjectContext: NSManagedObjectContext! {
        didSet {
            return home = Home(context: managedObjectContext)
        }
    }
    
    var soldPredicate: NSPredicate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        soldPredicate = NSPredicate(format: "isForSale = false")
        
        totalSalesDollarLabel.text = home?.getTotalHomeSales(moc: managedObjectContext)
        numCondoSoldLabel.text = home?.getNumberCondoSold(moc: managedObjectContext)
        numSFSoldLabel.text = home?.getNumberSingleFamilyHomeSold(moc: managedObjectContext)
        
        minPriceHomeLabel.text = home?.getHomePriceSold(priceType: "min", moc: managedObjectContext)
        maxPriceHomeLabel.text = home?.getHomePriceSold(priceType: "max", moc: managedObjectContext)
        avgPriceCondoLabel.text = home?.getAverageHomePrice(homeType: HomeType.Condo.rawValue, moc: managedObjectContext)
        avgPriceSFLabel.text = home?.getAverageHomePrice(homeType: HomeType.SingleFamily.rawValue, moc: managedObjectContext)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rowCount = 0
        
        switch section {
        case 0:
            rowCount = 3
        case 1, 2:
            rowCount = 2
        default:
            rowCount = 0
        }
        
        return rowCount
    }
}
