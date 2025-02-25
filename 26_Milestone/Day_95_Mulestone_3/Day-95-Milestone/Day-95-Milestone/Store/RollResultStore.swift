//
//  RollResultStore.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//
import SwiftUI
import SwiftData

@Observable
class RollResultStore {
//    static let shared = RollResultStore(modelContext: nil)
    
    var modelContext: ModelContext?
    
    var rollResults: [RollResult] = []
    
    init(modelContext: ModelContext?) {
        self.modelContext = modelContext
    }
    
    func save(_ result: RollResult) {
        modelContext?.insert(result)
        do {
            try modelContext?.save()
        } catch {
            print("error saving: \(error)")
        }
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
        do {
            try modelContext?.delete(model: RollResult.self)
            try modelContext?.save()
            fetchResults()
        } catch {
            print("failed to clear all: \(error)")
        }
    }
}

