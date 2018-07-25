//
//  HomeViewController.swift
//  CoreDataTutorial
//
//  Created by Heady on 20/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    weak var managedObjectContext:NSManagedObjectContext! {
        didSet{
            return home = Home(context: managedObjectContext)
        }
    }
    
    lazy var homes = [Home]()
    var selectedHome:Home? = nil
    var home:Home? = nil
    var isForSale:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.tableFooterView = UIView()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private Function
    private func loadData() {
        homes.removeAll()
        homes = home!.getHomeByStatus(isForSale: isForSale, moc: managedObjectContext)
        tableView.reloadData()
    }
    
    // MARK: Actions
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        isForSale = (selectedTitle.caseInsensitiveCompare("for sale") == .orderedSame)
        loadData()
    }
    
    // MARK: Tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCellId", for: indexPath) as! HomeViewCell
        
        let currentHome = homes[indexPath.row]
        cell.configureCell(homeObj: currentHome)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "historySeg" {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            selectedHome = homes[(selectedIndexPath?.row)!]
            
            let destinationVC = segue.destination as! SaleHistoryViewController
            destinationVC.home = selectedHome
            destinationVC.manageObjectContext = managedObjectContext
        }
    }
    
}
