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
        var store: RollResultStore?
        
        init(store: RollResultStore?) {
            self.store = store
        }
        
        var rollResults: [RollResult] {
            store?.rollResults ?? []
        }
        
        func fetchResults() {
            store?.fetchResults()
        }
        
        func clear() {
            store?.clearAll()
            store?.fetchResults()
        }
    }
}
