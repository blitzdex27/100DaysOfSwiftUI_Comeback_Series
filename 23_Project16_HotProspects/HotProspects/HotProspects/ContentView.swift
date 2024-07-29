//
//  ContentView.swift
//  HotProspects
//
//  Created by Dexter  on 7/29/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Send message", systemImage: "message") {
                        print("Hi")
                    }                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.orange)
                }
        }
    }
    
   
}

#Preview {
    ContentView()
}
