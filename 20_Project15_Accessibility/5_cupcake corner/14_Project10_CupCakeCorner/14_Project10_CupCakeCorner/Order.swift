//
//  Order.swift
//  14_Project10_CupCakeCorner
//
//  Created by Dexter Ramos on 6/19/24.
//

import Foundation


@Observable
class Order: Codable {
    static let options = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    let id = UUID()
    
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
        /// Challenge 1: Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
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
    
    enum CodingKeys: CodingKey {
        case _type
        case _count
        case _hasSpecialRequest
        case _addExtraFrosting
        case _addSprinkles
        case _name
        case _streetAddress
        case _city
        case _zip
    }
}



extension Order: Hashable {
    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
