//
//  CardStore.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/8/25.
//
import SwiftUI
import SwiftData

/// Extra challenge: Try to find a way to centralize the loading and saving code for the cards. You might need to experiment a little to find something you like!
@Observable
class CardStore {
    var cards: [CardV2] = []
    var modelContext: ModelContext?
    
    init(modelContext: ModelContext? = nil) {
        if let context = modelContext {
            fetchCards(from: context)
        }
        self.modelContext = modelContext
    }
    
    func fetchCards(from context: ModelContext) {
        let descriptor = FetchDescriptor<CardV2>()
        
        do {
            cards = try context.fetch(descriptor)
            
        } catch {
            print("Failed to fetch cards: \(error)")
        }
    }
    
    func removeCard(_ offsets: IndexSet) {
        guard let modelContext else {
            return
        }
        var cardsToDelete = [CardV2]()
        offsets.forEach { index in
            cardsToDelete.append(cards[index])
        }
        
        cardsToDelete.forEach { card in
            modelContext.delete(card)
        }
        
        do {
            try modelContext.save()
            fetchCards(from: modelContext)
        } catch {
            print("Delete card failed, \(error)")
        }
    }
    
    func removeCards(_ cards: Set<CardV2>) {
        guard let modelContext else {
            return
        }
        cards.forEach { card in
            modelContext.delete(card)
        }
        do {
            try modelContext.save()
            fetchCards(from: modelContext)
        } catch {
            print("Delete card failed, \(error)")
        }
    }
    
    func addCard(_ card: CardV2) {
        guard let modelContext else {
            return
        }
        
        modelContext.insert(card)
        do {
            try modelContext.save()
            fetchCards(from: modelContext)
        } catch {
            print("Add card failed, \(error)")
        }
        
    }
}

extension CardStore: EnvironmentKey {
    static var defaultValue = CardStore()
}

extension EnvironmentValues {
    var cardStore: CardStore {
        get { self[CardStore.self] }
        set { self[CardStore.self] = newValue }
    }
}
