//
//  FlashZilla2App.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 1/8/25.
//

import SwiftUI
import CoreData

let coreDataStore = URL.documentsDirectory.appendingPathComponent("Flashzilla.store")

@main
struct FlashZilla2App: App {
    var cardStore: CardStore
    
    init() {
        cardStore = CardStore(modelContext: PersistenceController.shared.container.viewContext)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.cardStore, cardStore)
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
