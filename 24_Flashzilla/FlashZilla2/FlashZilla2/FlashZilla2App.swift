//
//  FlashZilla2App.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 1/8/25.
//

import SwiftUI
import SwiftData

let coreDataStore = URL.documentsDirectory.appendingPathComponent("Flashzilla.store")

@main
struct FlashZilla2App: App {
    var sharedModelContainer: ModelContainer
    var cardStore: CardStore
    
    init() {
        do {
            let schema = Schema([Card.self])
            self.sharedModelContainer = try ModelContainer(for: schema, migrationPlan: CardsMigrationPlan.self)
            self.cardStore = CardStore(modelContext: sharedModelContainer.mainContext)
        } catch {
            fatalError("Error: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.cardStore, cardStore)
                .modelContainer(sharedModelContainer)
        }
    }
}
