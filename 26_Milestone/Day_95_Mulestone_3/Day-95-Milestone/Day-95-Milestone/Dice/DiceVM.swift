//
//  DiceVM.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/18/25.
//

import SwiftUI

@Observable
class DiceVM {
    
    var dice: Dice
    
    @MainActor
    var diceString: String {
        if dice.currentValue == 0 {
            return "?"
        } else {
            return String(dice.currentValue)
        }
    }
    
    init(dice: Dice) {
        self.dice = dice
    }
}
