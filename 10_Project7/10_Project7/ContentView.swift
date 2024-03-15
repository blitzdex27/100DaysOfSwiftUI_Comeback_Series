//
//  ContentView.swift
//  10_Project7
//
//  Created by Dexter Ramos on 3/13/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("tapcount") private var tapCount = 0
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            
        }
        
    }
}

#Preview {
    ContentView()
}
