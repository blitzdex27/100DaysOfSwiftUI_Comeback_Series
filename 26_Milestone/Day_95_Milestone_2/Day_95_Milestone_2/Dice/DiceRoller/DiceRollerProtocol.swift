//
//  DiceRollerProtocol.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//

protocol DiceRollerProtocol {
    func roll(dice: Die) -> Int
}

extension DiceRollerProtocol where Self == DiceRoller {
    static func `default`() -> DiceRoller {
        DiceRoller()
    }
}
