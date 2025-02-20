//
//  Day_95_MilestoneApp.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/14/25.
//

import SwiftUI
import SwiftData
import CoreHaptics

@main
struct Day_95_MilestoneApp: App {
    let container: ModelContainer
    var hapticEngine: CHHapticEngine?
    
    init() {
        let config = ModelConfiguration()
        let scheme = Schema([RollResult.self])
        container = try! ModelContainer(for: scheme, configurations: config)
        RollResultStore.shared.configure(modelContext: container.mainContext)
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("error starting haptic engine: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
                .environment(\.hapticEngine, hapticEngine)
        }
    }
}

extension CHHapticEngine: @retroactive EnvironmentKey {
    public static var defaultValue: CHHapticEngine? = try? CHHapticEngine()
}

extension EnvironmentValues {
    var hapticEngine: CHHapticEngine? {
        get {
            self[CHHapticEngine.self]
        }
        set {
            self[CHHapticEngine.self] = newValue
        }
    }
}
