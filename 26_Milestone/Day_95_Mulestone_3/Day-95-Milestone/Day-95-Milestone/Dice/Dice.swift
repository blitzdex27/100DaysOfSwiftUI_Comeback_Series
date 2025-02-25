//
//  Dice.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/14/25.
//
import SwiftData
import SwiftUI


@Model
class Dice: Identifiable {
    var currentValue: Int = 0
    var sideCount: Int
    var sideValues: [Int]
    
    init(sideCount: Int) {
        self.sideCount = sideCount
        self.sideValues = Array(1...sideCount)
    }
    
    @discardableResult
    @MainActor
    func roll() -> Int {
        let result = sideValues.randomElement()!
        return result
    }
    
    @MainActor
    func reset() {
        currentValue = 0
    }
}

extension Dice: SpecialCodable {
    func toCodable() -> CodableType {
        CodableType(
            currentValue: currentValue,
            sideCount: sideCount,
            sideValues: sideValues
        )
    }
    
    static func fromCodable(_ codable: CodableType) -> Dice {
        Dice(sideCount: codable.sideCount)
    }
    
    struct CodableType: Codable {
        var currentValue: Int = 0
        var sideCount: Int
        var sideValues: [Int]
    }
}

extension Array where Element == Dice {
    func getResults() -> [Int] {
        return map(\.currentValue)
    }
    
    func getResultSum() -> Int {
        guard !isEmpty else {
            return 0
        }
        return reduce(0) { partialResult, nextDice in
            partialResult + nextDice.currentValue
        }
    }
}

//extension Dice: CopyableProtocol {
//    func copy() -> Dice {
//        let diceCopy = Dice(sideCount: sideCount)
//        diceCopy.currentValue = currentValue
//        return diceCopy
//    }
//}
