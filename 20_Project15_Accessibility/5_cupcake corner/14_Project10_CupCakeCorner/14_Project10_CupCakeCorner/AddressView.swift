//
//  AddressView.swift
//  14_Project10_CupCakeCorner
//
//  Created by Dexter Ramos on 6/19/24.
//

import SwiftUI

struct AddressView: View {
    @Environment(\.orderStore) var orderStore
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section {
                NavigationLink("Check out") {
                    orderStore.save()
                    return CheckoutView(order: order)
                }
                .disabled(!order.hasValidAddress)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
