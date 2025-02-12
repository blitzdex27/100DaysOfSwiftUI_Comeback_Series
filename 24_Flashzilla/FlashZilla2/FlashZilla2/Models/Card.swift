//
//  Card.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/6/25.
//
import Foundation
import SwiftUI
import SwiftData

/// Extra challenge: Make it use an alternative approach to saving data, e.g. documents JSON rather than UserDefaults, or SwiftData – this is generally a good idea, so you should get practice with this.
typealias Card = CardsSchemaV2.Card

enum CardsSchemaV1: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Card.self]
    }
    
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    
    @Model
    class Card: Hashable, Identifiable {
        var prompt: String
        var answer: String
        init(prompt: String, answer: String) {
            self.prompt = prompt
            self.answer = answer
        }
        static let example = Card(prompt: "Who created this app?", answer: "Dexter")
    }
}

enum CardsSchemaV2: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [Card.self]
    }
    
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)
    
    @Model
    class Card: Hashable, Identifiable {
        var prompt: String
        var answer: String
        var correctCount: Int = 0
        
        init(prompt: String, answer: String, correctCount: Int = 0) {
            self.prompt = prompt
            self.answer = answer
            self.correctCount = correctCount
        }
        static let example = Card(prompt: "Who created this app?", answer: "Dexter", correctCount: 0)
    }
}
