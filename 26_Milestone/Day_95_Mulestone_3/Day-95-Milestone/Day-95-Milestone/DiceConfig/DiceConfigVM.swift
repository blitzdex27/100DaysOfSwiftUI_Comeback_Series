//
//  DiceConfigVM.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//
import SwiftUI

extension DiceConfigView {
    class ViewModel: ObservableObject {
        @Published var numberOfDie: Int = 1
        @Published var numberOfSide: Int = 6
        let saveAction: (_ numberOfDie: Int, _ numberOfSide: Int) -> Void
        
        init(numberOfDie: Int = 1, numberOfSide: Int = 1, saveAction: @escaping (_ numberOfDie: Int, _ numberOfSide: Int) -> Void) {
            self.numberOfDie = numberOfDie
            self.numberOfSide = numberOfSide
            self.saveAction = saveAction
        }
        
        func saveConfig() {
            saveAction(numberOfDie, numberOfSide)
        }
    }
}
