//
//  Dice.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//
import Foundation

@Observable
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
    
    func dynamicRoll(with roller: DiceRollerProtocol = .default(), completion: @escaping (Die) -> Void) {
        let result = roller.roll(dice: self)
        
        let numberOfPseudoRolls = Int.random(in: 1...6)
        
        var pseudoResults = Set<Int>()
        
        while pseudoResults.count < numberOfPseudoRolls {
            pseudoResults.insert(Int.random(in: 1...self.sideCount))
        }
        
        
        
        var arrayed = Array(pseudoResults)
        arrayed.shuffle()
        arrayed.insert(result, at: 0)

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if let popped = arrayed.popLast() {
                DispatchQueue.main.async {
                    self.facedUpSide = popped
                    
                }

            } else {
                completion(self)
                timer.invalidate()
            }
        }
        
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
