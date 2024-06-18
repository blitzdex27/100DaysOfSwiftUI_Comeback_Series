//
//  ContentView.swift
//  14_Project10_CupCakeCorner
//
//  Created by Dexter Ramos on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    @State var order: Order
    
    var body: some View {
        NavigationStack {
            List{
                Picker("Cupcake", selection: $order.type) {
                    ForEach(Order.options.indices, id: \.self) { index in
                        Text(Order.options[index])
                    }
                }
                
                Stepper("Quantity:  \(order.count)", value: $order.count, in: 2...12)
                
                Section {
                    Toggle("Special requests", isOn: $order.hasSpecialRequest)
                    
                    if order.hasSpecialRequest {
                        Toggle("Add extra frost", isOn: $order.addExtraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(order: Order())
}
