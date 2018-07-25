//
//  Date+Extenstion.swift
//  CoreDataTutorial
//
//  Created by Heady on 20/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation

extension Date {
    
    var ToString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
