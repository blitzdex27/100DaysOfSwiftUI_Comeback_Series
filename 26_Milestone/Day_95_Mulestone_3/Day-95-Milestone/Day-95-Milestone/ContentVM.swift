//
//  ContentVM.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//
import SwiftData

class ContentVM {
    @MainActor
    var diceCollection: DiceCollection = .init(dieCount: 1, sideCount: 6)

    
    @MainActor func saveRollResult()  {
        RollResultStore.shared.save(RollResult(diceCollection: diceCollection))
        RollResultStore.shared.fetchResults()
    }
    
    @MainActor
    func reset() {
        diceCollection.reset()
    }
}
