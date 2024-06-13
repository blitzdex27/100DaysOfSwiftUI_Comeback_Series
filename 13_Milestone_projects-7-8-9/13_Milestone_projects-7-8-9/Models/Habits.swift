//
//  Habits.swift
//  13_Milestone_projects-7-8-9
//
//  Created by Dexter  on 6/13/24.
//

import SwiftUI

@Observable class Habits: Codable {
    var items: [Habit] {
        didSet {
            habitStore?.save()
        }
    }
    
    weak var habitStore: HabitStoreProtocol?
    
    init(items: [Habit]) {
        self.items = items
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([Habit].self, forKey: .items)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
    }

    enum CodingKeys: CodingKey {
        case items
    }
    
}


extension EnvironmentValues {
    var habits: Habits {
        get { self[HabitsKey.self] }
        set { self[HabitsKey.self] = newValue}
    }
}

struct HabitsKey: EnvironmentKey {
    static var defaultValue = Habits(items: [])
}
