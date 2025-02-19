//
//  DiceCollection.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/14/25.
//
import Foundation
import SwiftData

@Model
class DiceCollection {
    var dice: [Dice]
    var currentValue: Int {
        dice.getResultSum()
    }
    
    init(dice: [Dice]) {
        self.dice = dice
    }
    
    @MainActor
    func rollAll() {
        
        for dice in self.dice {
            dice.roll()
        }
    }
    
    
    private func applyPaddingValues(on dice: Dice) async {
        let maximumPadCount = Int.random(in: 4...(4 + Int(Double(dice.sideCount) * 0.2)))
        let paddingValues: [Int] = Array(dice.sideValues.shuffled().prefix(Int.random(in: 1..<min(maximumPadCount, dice.sideCount))))
        print("values: \(paddingValues)")
        for paddingValue in paddingValues {
            DispatchQueue.main.async {
                dice.currentValue = paddingValue
            }
            try! await Task.sleep(for: .seconds(0.5))
        }
    }
    
    func reset() {
        dice.forEach { $0.reset() }
//        currentValue = 0
    }
    
    func update(dieCount: Int, sideCount: Int) {
        dice = (0..<dieCount).map { _ in
            Dice.init(sideCount: sideCount)
        }
//        currentValue = 0
    }
}

extension DiceCollection {
    convenience init(dieCount: Int, sideCount: Int) {
        let dice = (0..<dieCount).map { _ in
            Dice.init(sideCount: sideCount)
        }
        self.init(dice: dice)
    }
}

extension DiceCollection: CopyableProtocol {
    func copy() -> DiceCollection {
        let dice = dice.map({ $0.copy() })
        let collection = DiceCollection(dice: dice)
//        collection.currentValue = currentValue
        return collection
    }
}
