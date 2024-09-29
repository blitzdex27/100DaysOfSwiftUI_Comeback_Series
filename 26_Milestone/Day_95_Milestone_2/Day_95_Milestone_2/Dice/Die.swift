//
//  Dice.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//
import Foundation

class Die: Identifiable, Codable {
    var id: UUID
    var sideCount: Int
    var facedUpSide: Int?
    
    init(id: UUID = UUID(), sideCount: Int, facedUpSide: Int? = nil) {
        self.id = id
        self.sideCount = sideCount
        self.facedUpSide = facedUpSide
    }
    
    @discardableResult
    func roll(with roller: DiceRollerProtocol = .default()) -> Int {
        let result = roller.roll(dice: self)
        facedUpSide = result
        return result
    }
    
    func reset() {
        facedUpSide = nil
    }
}

extension Die: Hashable {
    static func ==(lhs: Die, rhs: Die) -> Bool {
        lhs.id == rhs.id && lhs.facedUpSide == rhs.facedUpSide
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
