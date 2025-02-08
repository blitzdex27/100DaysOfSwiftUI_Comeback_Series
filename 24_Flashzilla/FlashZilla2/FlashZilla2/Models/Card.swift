//
//  Card.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/6/25.
//
import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who created this app?", answer: "Dexter")
}
