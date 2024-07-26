//
//  OrderStore.swift
//  14_Project10_CupCakeCorner
//
//  Created by Dexter  on 6/21/24.
//

import SwiftUI

@Observable
class OrderStore {
    var order: Order
    
    private let key = "Order2"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key),
           let order = try? JSONDecoder().decode(Order.self, from: data) {
            self.order = order
        } else {
            self.order = Order()
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(order) {
            UserDefaults.standard.setValue(encoded, forKey: key)
        }
        
    }
}

extension EnvironmentValues {
    var orderStore: OrderStore {
        get { self[OrderStore.self] }
        set { self[OrderStore.self] = newValue }
    }
}

extension OrderStore: EnvironmentKey {
    static var defaultValue: OrderStore = OrderStore()
}
