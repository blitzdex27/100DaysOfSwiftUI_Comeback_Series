//
//  RollResultStore.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//

import SwiftData

@Observable
class RollResultStore {
    static let shared = RollResultStore()
    
    var modelContext: ModelContext?
    
    var rollResults: [RollResult] = []
    
    func configure(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }
    
    func save(_ result: RollResult) {
        modelContext?.insert(result)
        try? modelContext?.save()
    }
    
    func fetchResults() {
        let descriptor = FetchDescriptor<RollResult>()
        do {
            rollResults = try modelContext?.fetch(descriptor) ?? []
        } catch {
            print("Error fetching results: \(error)")
        }
    }
 
    func clearAll() {
        try? modelContext?.delete(model: RollResult.self)
        fetchResults()
    }
}
