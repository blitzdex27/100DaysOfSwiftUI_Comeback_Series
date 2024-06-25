//
//  _7_Milestone_project_10_12App.swift
//  17_Milestone_project-10-12
//
//  Created by Dexter  on 6/24/24.
//

import SwiftUI
import SwiftData
@main
struct _7_Milestone_project_10_12App: App {

//    private let container: ModelContainer = {
//        let config = ModelConfiguration(isStoredInMemoryOnly: false)
//        let container = try! ModelContainer(for: User.self, configurations: config)
//        return container
//    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self, isAutosaveEnabled: false)
    }
}
