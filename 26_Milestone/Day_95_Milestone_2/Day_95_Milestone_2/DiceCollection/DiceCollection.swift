//
//  DiceCollection.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//

import SwiftUI
import DekiPersistable
class DiceCollection: Codable, DekiPersistable {
    var dice: [Die]
    var rollResults: RollResults?
    
    init(dice: [Die]) {
        self.dice = dice
    }
    
    @discardableResult
    func roll(with roller: DiceRollerProtocol = .default()) -> RollResults {
        dice.forEach({ $0.roll(with: roller) })
        print(dice.compactMap({ $0.facedUpSide}))
        let rollResults = RollResults(dice: dice)
        self.rollResults = rollResults
        
        return rollResults
    }
    
    func reset(at offsets: IndexSet) {
        for index in offsets {
            dice[index].reset()
        }
        rollResults = RollResults(dice: dice)
    }

}
