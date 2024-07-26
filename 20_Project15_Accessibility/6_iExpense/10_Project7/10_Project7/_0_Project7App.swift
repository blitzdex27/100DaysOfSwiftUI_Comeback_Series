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
    
    @State private var appModel = AppModel.makeDummy()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.appModel, appModel)
        }
        .modelContainer(for: Expense.self)
    }
}
