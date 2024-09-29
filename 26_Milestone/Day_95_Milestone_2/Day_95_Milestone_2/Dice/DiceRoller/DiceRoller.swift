//
//  DiceRoller.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//

class DiceRoller: DiceRollerProtocol {
    func roll(dice: Die) -> Int {
        Int.random(in: 1...dice.sideCount)
    }
}
