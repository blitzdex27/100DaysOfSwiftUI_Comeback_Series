//
//  DiceCollectionView+VM.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/25/24.
//

import SwiftUI

extension DiceCollectionView {
    @Observable
    class ViewModel {
        private(set) var diceCollection: DiceCollection
        
        var dice: [Die]
        var diceResults: [Int]?
        var diceResultsTotal: Int?
        
        init(dieCount: Int, sideCount: Int = 6) {
            let die = Die(sideCount: sideCount)
            let dice = (0..<dieCount).map({ _ in Die(sideCount: sideCount) })
            
            let collection = DiceCollection(dice: dice)
            self.diceCollection = collection
            
            self.dice = collection.dice
            
            let rollResults = collection.rollResults
            diceResults = rollResults?.results
            diceResultsTotal = rollResults?.total
        }
        
        init(diceCollection: DiceCollection) {
            self.diceCollection = diceCollection
            self.dice = diceCollection.dice
            
            let rollResults = diceCollection.rollResults
            self.diceResults = rollResults?.results
            self.diceResultsTotal = rollResults?.total
        }
        
        @discardableResult
        func roll(with roller: DiceRollerProtocol = .default()) -> DiceCollection.RollResults? {
            diceCollection.roll(with: roller)
            Task {
                try await diceCollection.save()
            }
            let rollResults = diceCollection.rollResults
            updateDicePresentableData(with: rollResults)
            return rollResults
        }
        
        func reset(at offsets: IndexSet) {
            diceCollection.reset(at: offsets)
            updateDicePresentableData(with: diceCollection.rollResults)
        }
        
        func resetAll() {
            diceCollection.reset(at: IndexSet(0..<dice.count))
            updateDicePresentableData(with: diceCollection.rollResults)
        }
        
        
        private func updateDicePresentableData(with rollResults: DiceCollection.RollResults?) {
            updateDice()
            updateDiceResults(with: rollResults)
            updateDiceResultsTotal(with: rollResults)
        }
        
        private func updateDice() {
            dice = diceCollection.dice
            print(dice.compactMap({ $0.facedUpSide }))
        }
        
        private func updateDiceResults(with rollResults: DiceCollection.RollResults?) {
            diceResults = rollResults?.results
        }
        
        private func updateDiceResultsTotal(with rollResults: DiceCollection.RollResults?) {
            diceResultsTotal = rollResults?.total
        }
    }
}
