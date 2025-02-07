//
//  Card.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/6/25.
//
import Foundation

struct Card: Identifiable {
    var id: UUID = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who created this app?", answer: "Dexter")
}
