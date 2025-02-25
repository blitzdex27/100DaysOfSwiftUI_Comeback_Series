//
//  Day_95_MilestoneApp.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/14/25.
//

import SwiftUI
import SwiftData
import CoreHaptics
import UniformTypeIdentifiers

@main
struct Day_95_MilestoneApp: App {
    var hapticEngine: CHHapticEngine?
    @StateObject private var config = Config()
    init() {
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("error starting haptic engine: \(error)")
        }
    }
    
    var body: some Scene {

        DocumentGroup(editing: RollResult.self,  contentType: .results) {
            ContentWrapperView()
                            .environment(\.hapticEngine, hapticEngine)
                            .environment(\.config, config)
        }

    }
}

extension UTType {
    static var results = UTType(exportedAs: "com.dekideks.100DaysSwiftUI.Day-95-Milestone.results")
}
