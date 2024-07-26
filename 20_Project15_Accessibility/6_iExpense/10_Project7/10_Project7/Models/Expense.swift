//
//  Expense.swift
//  10_Project7
//
//  Created by Dexter Ramos on 6/23/24.
//

import Foundation
import SwiftData

@Model
class Expense {
    let name: String
    let type: String
    let amount: Double
    let dateCreated: Date = Date.now
    
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

