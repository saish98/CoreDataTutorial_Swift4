//
//  SummaryViewController.swift
//  CoreDataTutorial
//
//  Created by Heady on 20/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
import CoreData

class SummaryViewController: UIViewController {

    weak var managedObjectContext:NSManagedObjectContext! {
        didSet {
                
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
