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
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(count) * 2

        // complicated cakes cost more
        cost += (Decimal(type) / 2)

        // $1/cake for extra frosting
        if addExtraFrosting {
            cost += Decimal(count)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(count) / 2
        }

        return cost
    }
}
