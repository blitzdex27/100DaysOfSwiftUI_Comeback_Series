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
//        let schema = Schema([Card.self])
//        let config = ModelConfiguration(url: coreDataStore)
        self.sharedModelContainer = migrateFromV1ToV2()//try! ModelContainer(for: schema, configurations: config)//
//        let context = sharedModelContainer.mainContext
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

@MainActor
func checkCards() {
    let schema = Schema([Card.self])
    let container = try! ModelContainer(for: schema)
    let cards = try! container.mainContext.fetch(FetchDescriptor<Card>())
    print("cards count: \(cards.count)")

}

@MainActor
func migrateFromV1ToV2() -> ModelContainer {
    let config = ModelConfiguration(url: coreDataStore)
    
    let schemaV1 = Schema([Card.self])
    let schemaV2 = Schema([CardV2.self])
    
    do {
        let modelContainerV1 = try ModelContainer(for: schemaV1, configurations: config)
        let contextV1 = modelContainerV1.mainContext
        let descriptor = FetchDescriptor<Card>()
        let cardsV1 = try contextV1.fetch(descriptor)
        
        let modelContainerV2 = try ModelContainer(for: schemaV2, configurations: config)
        
        let contextV2 = modelContainerV2.mainContext
        
        
        for card in cardsV1 {
            let cardV2 = CardV2(prompt: card.prompt, answer: card.answer)
            contextV2.insert(cardV2)
        }
        try contextV2.save()
        return modelContainerV2
    } catch {
        fatalError("unable to migrate: \(error)")
    }
}
