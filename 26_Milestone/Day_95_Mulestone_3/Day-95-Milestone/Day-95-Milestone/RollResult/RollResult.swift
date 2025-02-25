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

extension RollResult: SpecialCodable {
    func toCodable() -> CodableType {
        CodableType(
            result: result,
            values: values,
            diceCollection: diceCollection.toCodable()
        )
    }
    
    static func fromCodable(_ codable: CodableType) -> RollResult {
        RollResult(diceCollection: DiceCollection.fromCodable(codable.diceCollection))
    }
    
    struct CodableType: Codable {
        var result: Int
        var values: [Int]
        var diceCollection: DiceCollection.CodableType
    }
}

extension RollResult {
   
}
