//
//  HabitStore.swift
//  13_Milestone_projects-7-8-9
//
//  Created by Dexter  on 6/13/24.
//

import SwiftUI

protocol HabitStoreProtocol: AnyObject {
    var habits: Habits { get set }
    func save()
}

@Observable class HabitStore: HabitStoreProtocol {
    var habits: Habits
    
    private let habitSave = URL.documentsDirectory.appendingPathComponent("HabitSave")
    
    init() {
        let decoder = JSONDecoder()
        if let data = try? Data(contentsOf: habitSave),
           let decoded = try? decoder.decode(Habits.self, from: data)
        {
            habits = decoded
        } else {
            habits = Habits(items: [])
        }
        habits.habitStore = self
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        do {
            let encoded = try encoder.encode(habits)
            try encoded.write(to: habitSave)
        } catch {
            print("unable to write")
        }
    }
}


extension EnvironmentValues {
    var habitStore: HabitStore {
        get { self[HabitStoreKey.self] }
        set { self[HabitStoreKey.self] = newValue }
    }
}

struct HabitStoreKey: EnvironmentKey {
    static var defaultValue = HabitStore()
}
