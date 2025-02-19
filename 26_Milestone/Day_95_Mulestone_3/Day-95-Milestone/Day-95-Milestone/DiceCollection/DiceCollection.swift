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
    
    @MainActor
    var currentValue: Int {
        dice.getResultSum()
    }
    
    init(dice: [Dice]) {
        self.dice = dice
    }
    
    @MainActor
    func rollAll() {
        
        for dice in self.dice {
            dice.currentValue = dice.roll()
        }
    }

    @MainActor
    func reset() {
        
        for die in dice {
            die.reset()
        }
//        currentValue = 0
    }
    
    @MainActor
    func update(dieCount: Int, sideCount: Int) {
        dice = (0..<dieCount).map { _ in
            Dice.init(sideCount: sideCount)
        }
//        currentValue = 0
    }
}

extension DiceCollection {
    @MainActor
    convenience init(dieCount: Int, sideCount: Int) {
        let dice = (0..<dieCount).map { _ in
            Dice.init(sideCount: sideCount)
        }
        self.init(dice: dice)
    }
}

//extension DiceCollection: CopyableProtocol {
//    func copy() -> DiceCollection {
//        let dice = dice.map({ $0.copy() })
//        let collection = DiceCollection(dice: dice)
////        collection.currentValue = currentValue
//        return collection
//    }
//}
