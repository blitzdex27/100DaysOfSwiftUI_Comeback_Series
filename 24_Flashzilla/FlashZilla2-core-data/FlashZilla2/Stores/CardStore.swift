//
//  CardStore.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/8/25.
//
import SwiftUI
import CoreData

/// Extra challenge: Try to find a way to centralize the loading and saving code for the cards. You might need to experiment a little to find something you like!
@Observable
class CardStore {
    var cards: [Card] = []
    var modelContext: NSManagedObjectContext?
    
    init(modelContext: NSManagedObjectContext? = nil) {
        if let context = modelContext {
            fetchCards(from: context)
        }
        self.modelContext = modelContext
    }
    
    func fetchCards(from context: NSManagedObjectContext) {
        do {
            let request = NSFetchRequest<Card>(entityName: "Card")
            cards = try context.fetch(request)
            
        } catch {
            cards = []
            print("Failed to fetch cards: \(error)")
        }
    }
    
    func removeCard(_ offsets: IndexSet) {
        guard let modelContext else {
            return
        }
        var cardsToDelete = [Card]()
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
    
    func removeCards(_ cards: Set<Card>) {
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
    
    func addCard(prompt: String, answer: String) {
        guard let modelContext else {
            return
        }
        
        let card = Card(context: modelContext)
        card.prompt = prompt
        card.answer = answer
        
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
