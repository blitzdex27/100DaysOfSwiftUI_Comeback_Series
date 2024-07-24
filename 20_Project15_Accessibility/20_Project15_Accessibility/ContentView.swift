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
//        "galina-n-189483",
//        "kevin-horstmann-141705",
//        "nicolas-tissot-335096"
//    ]
//    
//    let labels = [
//        "Tulips",
//        "Frozen tree buds",
//        "Sunflowers",
//        "Fireworks"
//    ]

//    @State private var selectedPicture = Int.random(in: 0...3)
    
    @State private var value = 10

    var body: some View {
        VStack {
            Text("Value: \(value)")
            Button("Increment") {
                value += 1
            }
            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Value")
        .accessibilityValue("\(value)")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            @unknown default:
                print("not handled")
            }
        }
        
    }
}

#Preview {
    ContentView()
}
