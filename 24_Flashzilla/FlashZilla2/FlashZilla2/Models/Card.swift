//
//  Card.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/6/25.
//
import Foundation

struct Card: Codable, Identifiable {
    let id: UUID
    var prompt: String
    var answer: String
    
    init(id: UUID = UUID(), prompt: String, answer: String) {
        self.id = id
        self.prompt = prompt
        self.answer = answer
    }
    static let example = Card(prompt: "Who created this app?", answer: "Dexter")
}
