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



@Model
class CardV2: Hashable, Identifiable {
    var question: String
    var answer: String
    init(prompt: String, answer: String) {
        self.question = prompt
        self.answer = answer
    }
    static let example = CardV2(prompt: "Who created this app?", answer: "Dexter")
}
