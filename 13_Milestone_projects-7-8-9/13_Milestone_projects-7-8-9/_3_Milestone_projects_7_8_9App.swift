//
//  _3_Milestone_projects_7_8_9App.swift
//  13_Milestone_projects-7-8-9
//
//  Created by Dexter  on 6/13/24.
//

import SwiftUI

@main
struct _3_Milestone_projects_7_8_9App: App {
    
    private let habitStore = HabitStore()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.habits, habitStore.habits)
                .environment(\.habitStore, habitStore)
        }
    }
}
