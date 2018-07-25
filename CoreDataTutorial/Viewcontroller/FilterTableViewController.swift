//
//  FilterTableViewController.swift
//  CoreDataTutorial
//
//  Created by Heady on 20/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
protocol FilterTableViewControllerDelegate {
    func updatehomeList(filterBy: NSPredicate?, sortBy: NSSortDescriptor?)
}

class FilterTableViewController: UITableViewController {

    // SORT BY
    @IBOutlet weak var sortByLocationCell: UITableViewCell!
    @IBOutlet weak var sortByPriceLowHighCell: UITableViewCell!
    @IBOutlet weak var sortByPriceHighLowCell: UITableViewCell!
    
    // FILTER by home type
    @IBOutlet weak var filterByCondoCell: UITableViewCell!
    @IBOutlet weak var filterBySingleFamilyCell: UITableViewCell!
    
    // MARK: Filter
    @IBOutlet weak var typeSingleFamily: UILabel!
    @IBOutlet weak var typeCondo: UILabel!
    
    // MARK: Sort
    @IBOutlet weak var priceHighToLow: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var priceLowToHigh: UILabel!
    
    var sortDescriptor:NSSortDescriptor?
    var searchPredicate:NSPredicate?
    var delegate: FilterTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 3
        default:
            return 2
        }
    }

   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        switch selectedCell {
        case sortByLocationCell:
            sortBy(text: "city", isAscending: true)
        case sortByPriceLowHighCell:
            sortBy(text: "price", isAscending: true)
        case sortByPriceHighLowCell:
            sortBy(text: "price", isAscending: false)
        case filterByCondoCell, filterBySingleFamilyCell:
            filterBy(text: (selectedCell?.textLabel?.text)!)
        case .none: break
            
        case .some(_): break
            
        }
        
        selectedCell?.accessoryType = .checkmark
        self.delegate?.updatehomeList(filterBy: searchPredicate, sortBy: sortDescriptor)
    }
    
    private func sortBy(text:String, isAscending:Bool) {
        sortDescriptor = NSSortDescriptor(key: text, ascending: isAscending)
        
    }
    
    private func filterBy(text: String) {
        searchPredicate = NSPredicate(format: "homeType = %@", text)
    }

}
