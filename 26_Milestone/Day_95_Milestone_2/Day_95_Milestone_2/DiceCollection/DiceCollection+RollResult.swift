//
//  DiceCollection+RollResult.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/26/24.
//

extension DiceCollection {
    struct RollResults: Codable {
        var results: [Int]
        var total: Int
        
        init(dice: [Die]) {
            self.results = dice.map({ $0.facedUpSide ?? 0 })
            self.total = dice.reduce(0, { $0 + ($1.facedUpSide ?? 0) })
        }
    }
}
