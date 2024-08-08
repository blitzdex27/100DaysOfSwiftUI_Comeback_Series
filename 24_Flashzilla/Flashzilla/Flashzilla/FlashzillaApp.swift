//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Dexter  on 7/30/24.
//

import SwiftUI
import SwiftData

@main
struct FlashzillaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Card.self)
    }
}
