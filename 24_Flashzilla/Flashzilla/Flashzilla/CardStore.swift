//
//  CardStore.swift
//  Flashzilla
//
//  Created by Dexter  on 8/8/24.
//

import Foundation

class CardStore {
    var cards: [Card]
    
    static let shared = CardStore()
    private let saveUrl = URL.documentsDirectory.appendingPathComponent("Cards")
    
    init() {
        do {
            let data = try Data(contentsOf: saveUrl)
            cards = try JSONDecoder().decode([Card].self, from: data)
        } catch {
            cards = []
        }
    }
    
    func save() {
        do {
            let encoded = try JSONEncoder().encode(cards)
            try encoded.write(to: saveUrl)
        } catch {
            print("unable to write")
        }
    }
    
    static func loadData() -> [Card] {
        return shared.cards
    }
    
    static func saveCards(_ cards: [Card]) {
        shared.cards = cards
        shared.save()
    }
}
