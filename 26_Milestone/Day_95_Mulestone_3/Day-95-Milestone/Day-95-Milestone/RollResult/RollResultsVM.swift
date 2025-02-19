//
//  RollResultsVM.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//

import SwiftUI

extension RollResultsView {
    
    @Observable
    class ViewModel {
        var rollResults: [RollResult] {
            RollResultStore.shared.rollResults
        }
        
        func clear() {
            RollResultStore.shared.clearAll()
            RollResultStore.shared.fetchResults()
        }
    }
}
