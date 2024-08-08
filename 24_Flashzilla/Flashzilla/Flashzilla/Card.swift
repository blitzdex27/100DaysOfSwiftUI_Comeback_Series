//
//  Card.swift
//  Flashzilla
//
//  Created by Dexter  on 8/2/24.
//

import Foundation

struct Card: Codable, Identifiable, Equatable  {
    var id: UUID
    var prompt: String
    var answer: String

    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
