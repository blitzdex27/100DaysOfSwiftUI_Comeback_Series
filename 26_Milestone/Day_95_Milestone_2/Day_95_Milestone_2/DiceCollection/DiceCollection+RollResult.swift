//
//  DiceCollection+RollResult.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/26/24.
//

extension DiceCollection {
    struct RollResults: Codable, Equatable {
        var results: [Int]
        var total: Int
        
        init?(dice: [Die]) {
            let results = dice.compactMap({ $0.facedUpSide })
            guard !results.isEmpty else {
                return nil
            }
            self.results = results
            self.total = dice.reduce(0, { $0 + ($1.facedUpSide ?? 0) })
        }
    }
}
