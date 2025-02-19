//
//  ContentVM.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//
import SwiftData

class ContentVM {
    var diceCollection: DiceCollection = .init(dieCount: 1, sideCount: 6)

    
    func saveRollResult()  {
        RollResultStore.shared.save(RollResult(diceCollection: diceCollection))
        RollResultStore.shared.fetchResults()
    }
    
    func reset() {
        diceCollection.reset()
    }
}
