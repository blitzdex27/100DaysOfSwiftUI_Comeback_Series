//
//  ContentVM.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//
import SwiftUI

class ContentVM: ObservableObject, ContentVMProtocol {
    var store: RollResultStore

    @Published
    var diceCollection: DiceCollection = .init(dieCount: 1, sideCount: .constant(6))

    init(
        store: RollResultStore,
        diceCollection: DiceCollection = DiceCollection(dieCount: 1, sideCount: .constant(6))
    ) {
        self.store = store
        self.diceCollection = diceCollection
    }
    
    @MainActor
    func saveRollResult()  {
        store.save(RollResult(diceCollection: diceCollection))
        store.fetchResults()
    }
    
    @MainActor
    func reset() {
        diceCollection.reset()
    }
    
    @MainActor
    func updateCollection(dieCount: Int, sideCount: DiceCollection.SideCount) {
        diceCollection.update(dieCount: dieCount, sideCount: sideCount)
    }
}
