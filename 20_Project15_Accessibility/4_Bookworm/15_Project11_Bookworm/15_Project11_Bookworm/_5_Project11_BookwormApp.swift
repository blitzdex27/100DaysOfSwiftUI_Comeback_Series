//
//  _5_Project11_BookwormApp.swift
//  15_Project11_Bookworm
//
//  Created by Dexter  on 6/21/24.
//

import SwiftUI
import SwiftData

@main
struct _5_Project11_BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .modelContainer(for: Book.self)
    }
}
