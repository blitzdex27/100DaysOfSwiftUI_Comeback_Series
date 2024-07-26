//
//  ContentView.swift
//  20_Project15_Accessibility
//
//  Created by Dexter Ramos on 7/23/24.
//

import SwiftUI

struct ContentView: View {
//    let pictures = [
//        "ales-krivec-15949",

    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button Tapped")
        }
        .accessibilityInputLabels(["Kennedy", "John Fitzgerald Kennedy", "Fitzgerald"])
    }
}

#Preview {
    ContentView()
}
