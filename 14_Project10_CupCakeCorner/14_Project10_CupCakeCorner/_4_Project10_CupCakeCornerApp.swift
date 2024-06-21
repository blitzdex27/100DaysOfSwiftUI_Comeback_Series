//
//  _4_Project10_CupCakeCornerApp.swift
//  14_Project10_CupCakeCorner
//
//  Created by Dexter Ramos on 6/17/24.
//

import SwiftUI

@main
struct _4_Project10_CupCakeCornerApp: App {
    
    private let orderStore = OrderStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView(order: orderStore.order)
                .environment(\.orderStore, orderStore)
        }
    }
}
