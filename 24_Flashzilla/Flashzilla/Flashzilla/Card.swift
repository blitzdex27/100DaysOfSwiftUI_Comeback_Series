//
//  Card.swift
//  Flashzilla
//
//  Created by Dexter  on 8/2/24.
//

import Foundation
import SwiftData

@Model
class Card: Codable, Identifiable, Equatable  {
    var id: UUID
    var prompt: String
    var answer: String

    init(id: UUID, prompt: String, answer: String) {
        self.id = id
        self.prompt = prompt
        self.answer = answer
    }
    
    
    

    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    
    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case _prompt = "prompt"
        case _answer = "answer"
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: ._id)
        prompt = try container.decode(String.self, forKey: ._prompt)
        answer = try container.decode(String.self, forKey: ._answer)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: ._id)
        try container.encode(prompt, forKey: ._prompt)
        try container.encode(answer, forKey: ._answer)
    }
}
