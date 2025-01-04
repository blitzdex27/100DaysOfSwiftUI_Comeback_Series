//
//  HotProspects2App.swift
//  HotProspects2
//
//  Created by Dexter Ramos on 12/21/24.
//

import SwiftUI
import SwiftData

@main
struct HotProspects2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Prospect.self)
        }
    }
}
