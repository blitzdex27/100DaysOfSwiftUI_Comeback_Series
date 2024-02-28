//
//  ContentView.swift
//  6_Retry_Project3
//
//  Created by Dexter Ramos on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    var body: some View {
        Stepper("Sleep Amount: \(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
    }
}

#Preview {
    ContentView()
}
