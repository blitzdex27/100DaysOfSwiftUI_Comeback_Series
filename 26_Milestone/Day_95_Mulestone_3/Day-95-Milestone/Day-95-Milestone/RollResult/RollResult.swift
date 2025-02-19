//
//  RollResult.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/18/25.
//
import Foundation
import SwiftData

@Model
class RollResult: Identifiable {
    var result: Int
    var values: [Int]
    var diceCollection: DiceCollection
    
    @MainActor
    init(diceCollection: DiceCollection) {
        self.result = diceCollection.currentValue
        self.values = diceCollection.dice.map(\.currentValue)
        self.diceCollection = diceCollection
    }

}

extension RollResult: Equatable, Hashable {
    
    static func == (lhs: RollResult, rhs: RollResult) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
