//
//  ContentView.swift
//  6_Retry_Project3
//
//  Created by Dexter Ramos on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    @State private var date = Date.now
    var body: some View {
        Text(Date.now.formatted(date: .numeric, time: .standard))
    }
}

#Preview {
    ContentView()
}

//struct ContentView: View {
//    @State private var sleepAmount = 8.0
//    var body: some View {
//        Stepper("Sleep Amount: \(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
//    }
//}

//struct ContentView: View {
//    @State private var date = Date.now
//    var body: some View {
//        DatePicker("Please select date:", selection: $date, in: date..., displayedComponents: .date)
//            .labelsHidden()
//    }
//}
