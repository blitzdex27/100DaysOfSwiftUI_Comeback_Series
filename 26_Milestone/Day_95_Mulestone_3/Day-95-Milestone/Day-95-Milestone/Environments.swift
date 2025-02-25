//
//  Environments.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/21/25.
//
import SwiftUI
import CoreHaptics

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

extension RollResultStore: EnvironmentKey {
    static var defaultValue = RollResultStore(modelContext: nil)
}

extension EnvironmentValues {
    var rollResultStore: RollResultStore? {
        get {
            self[RollResultStore.self]
        } set {
            self[RollResultStore.self] = newValue
        }
    }
}

extension Config: EnvironmentKey {
    static var defaultValue = Config()
}

extension EnvironmentValues {
    var config: Config {
        get { self[Config.self] }
        set { self[Config.self] = newValue }
    }
}
