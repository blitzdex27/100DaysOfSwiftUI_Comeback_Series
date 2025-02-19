//
//  Day_95_MilestoneApp.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/14/25.
//

import SwiftUI
import SwiftData
@main
struct Day_95_MilestoneApp: App {
    let container: ModelContainer
    
    init() {
        let config = ModelConfiguration()
        let scheme = Schema([RollResult.self])
        container = try! ModelContainer(for: scheme, configurations: config)
        RollResultStore.shared.configure(modelContext: container.mainContext)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
}
