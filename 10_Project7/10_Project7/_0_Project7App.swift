//
//  _0_Project7App.swift
//  10_Project7
//
//  Created by Dexter Ramos on 3/13/24.
//

import SwiftUI
import SwiftData

@main
struct _0_Project7App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
