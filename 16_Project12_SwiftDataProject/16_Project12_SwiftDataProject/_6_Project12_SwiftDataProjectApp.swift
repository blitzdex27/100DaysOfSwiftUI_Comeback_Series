//
//  _6_Project12_SwiftDataProjectApp.swift
//  16_Project12_SwiftDataProject
//
//  Created by Dexter  on 6/22/24.
//

import SwiftData
import SwiftUI

@main
struct _6_Project12_SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .modelContainer(for: User.self)
    }
}
