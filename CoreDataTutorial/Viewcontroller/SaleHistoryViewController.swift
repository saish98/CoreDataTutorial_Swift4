//
//  SaleHistoryViewController.swift
//  CoreDataTutorial
//
//  Created by Heady on 26/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
import CoreData

class SaleHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: PROPERTY
    lazy var saleHistory = [SaleHistory]()
    var home: Home?
    weak var manageObjectContext:NSManagedObjectContext!
    
    // MARK: OUTLET
    @IBOutlet weak var imageViewHome: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
        
        if let homeImg = home?.image {
            let image = UIImage(data: homeImg as Data)
            self.imageViewHome.image = image
        }
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: PRIVATE FUNCTION
    private func loadData() {
        let saleHistoryDB = SaleHistory(context: manageObjectContext)
        saleHistory = saleHistoryDB.getSoldHistory(home: home!, moc: manageObjectContext)
        
        tableView.reloadData()
    }
    // MARK: TABLEVIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCellId", for: indexPath) as! HistoryCell
        
        let saleHistoryObj = self.saleHistory[indexPath.row]
        cell.configureCell(saleHistoryObj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saleHistory.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
