//
//  Order.swift
//  14_Project10_CupCakeCorner
//
//  Created by Dexter Ramos on 6/19/24.
//

import Foundation

@Observable
class Order {
    static let options = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var count = 2
    var hasSpecialRequest = false {
        willSet {
            addExtraFrosting = false
            addSprinkles = false
        }
    }
    var addExtraFrosting = false
    var addSprinkles = false
}
