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
    var dieCount: Int
//    @Transient var sideCount: SideCount = .constant(6)
    var currentValue: Int
    
    init(dice: [Dice]) {
        self.dice = dice
        self.dieCount = dice.count
        self.currentValue = dice.getResultSum()
    }
    
    init(dieCount: Int, sideCount: SideCount) {
        self.dieCount = dieCount
//        self.sideCount = sideCount
        
        let dice = (0..<dieCount).map { _ in
            Dice(sideCount: sideCount.getCount())
        }
        self.dice = dice
        self.currentValue = dice.getResultSum()
    }
    
    @MainActor
    func rollAll(eachCompletion: ((Dice) -> Void)? = nil) {
        
        for dice in self.dice {
            dice.currentValue = dice.roll()
            eachCompletion?(dice)
        }
    }

    @MainActor
    func reset() {
        for die in dice {
            die.reset()
        }
        currentValue = dice.getResultSum()
    }
    
    @MainActor
    func update(dieCount: Int, sideCount: SideCount) {
        self.dieCount = dieCount
//        self.sideCount = sideCount
        
        
        dice = (0..<dieCount).map { _ in
            Dice(sideCount: sideCount.getCount())
        }
    }
}

extension DiceCollection: SpecialCodable {
    func toCodable() -> Codabletype {
        Codabletype(
            dice: dice.map { $0.toCodable() },
            dieCount: dieCount,
            currentValue: currentValue
        )
    }
    
    static func fromCodable(_ codable: Codabletype) -> DiceCollection {
        DiceCollection(dice: codable.dice.map { Dice.fromCodable($0) })
    }
    
    struct Codabletype: Codable {
        var dice: [Dice.CodableType]
        var dieCount: Int
        var currentValue: Int
    }
    
}


extension DiceCollection {
    class SideCount {
        var getCount: () -> Int
        
        init(_ getCount: @escaping () -> Int) {
            self.getCount = getCount
        }
        
        static func constant(_ count: Int) -> SideCount {
            SideCount { count }
        }
        
        static func random(in range: ClosedRange<Int>) -> SideCount {
            SideCount { Int.random(in: range) }
        }
    }
}
