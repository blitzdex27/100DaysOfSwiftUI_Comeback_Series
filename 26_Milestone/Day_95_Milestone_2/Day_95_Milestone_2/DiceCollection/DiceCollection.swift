//
//  DiceCollection.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//

import SwiftUI
import DekiPersistable
import OSLog

@Observable
class DiceCollection: Codable, DekiPersistable {
    var dice: [Die]
    var rollResults: RollResults?
    
    
    
    init(dice: [Die]) {
        self.dice = dice
    }
    
    @discardableResult
    func roll(with roller: DiceRollerProtocol = .default()) -> RollResults {
        dice.forEach({ $0.roll(with: roller) })
        
        os_log(.info, "\(self.dice.compactMap({ $0.facedUpSide}))")
        let rollResults = RollResults(dice: dice)
        self.rollResults = rollResults
        
        return rollResults!
    }
    
    func dynamicRoll(with roller: DiceRollerProtocol = .default(), completion: @escaping (RollResults?) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        for die in dice {
            dispatchGroup.enter()
            die.dynamicRoll { _ in
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main, work: DispatchWorkItem(block: {
            self.rollResults = RollResults(dice: self.dice)
            completion(self.rollResults)
        }))
//        dice.forEach({ $0.dynamicRoll(with: roller) { _ in } })
     
    }
    
    func reset(at offsets: IndexSet) {
        for index in offsets {
            dice[index].reset()
        }
//        rollResults = RollResults(dice: dice)
    }

}

extension DiceCollection {
    static func make(diceCount: Int = 1, sideCount: Int = 6) -> DiceCollection {
        let dice = (0..<diceCount).map({ _ in Die(sideCount: sideCount) })
        return DiceCollection(dice: dice)
    }
}
