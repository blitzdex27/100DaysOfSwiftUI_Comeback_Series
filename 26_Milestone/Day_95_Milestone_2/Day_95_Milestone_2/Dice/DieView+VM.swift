//
//  DieView+VM.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//
import SwiftUI
import Combine

extension DieView {
    @Observable
    class ViewModel {
        private(set) var die: Die
        
        var result: Int? {
            die.facedUpSide
        }
        
        init(die: Die) {
            self.die = die

        }
        
        func roll() -> Int {
            let result = die.roll()
            updateResult()
            return result
        }
        
        func dynamicRoll(completion: @escaping (Die) -> Void) {
            die.dynamicRoll(completion: completion)
        }
        
        func reset() {
            die.reset()
            updateResult()
        }
        
        private func updateResult() {
//            result = die.facedUpSide
        }
    }
}
