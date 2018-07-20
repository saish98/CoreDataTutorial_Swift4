//
//  Double+Extension.swift
//  CoreDataTutorial
//
//  Created by Heady on 20/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation

extension Double {
    
    var currencyFormatter:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self))!
    }
}
