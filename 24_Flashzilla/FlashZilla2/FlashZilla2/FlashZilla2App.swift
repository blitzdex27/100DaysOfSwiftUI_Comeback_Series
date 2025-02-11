//
//  FlashZilla2App.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 1/8/25.
//

import SwiftUI
import SwiftData

@main
struct FlashZilla2App: App {
    var sharedModelContainer: ModelContainer
    var cardStore: CardStore
    
    init() {
        let schema = Schema([Card.self])
        self.sharedModelContainer = try! ModelContainer(for: schema)
        self.cardStore = CardStore(modelContext: sharedModelContainer.mainContext)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.cardStore, cardStore)
                .modelContainer(sharedModelContainer)
        }
    }
}
