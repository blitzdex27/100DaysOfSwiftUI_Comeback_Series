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
        private var dice: Die
        
        var result: Int? {
            dice.facedUpSide
        }
        
        init(sides: Int) {
            self.dice = Die(sideCount: sides)
        }
        
        init(die: Die) {
            self.dice = die

        }
        
        func roll() -> Int {
            let result = dice.roll()
            updateResult()
            return result
        }
        
        func reset() {
            dice.reset()
            updateResult()
        }
        
        private func updateResult() {
//            result = dice.facedUpSide
        }
    }
}
