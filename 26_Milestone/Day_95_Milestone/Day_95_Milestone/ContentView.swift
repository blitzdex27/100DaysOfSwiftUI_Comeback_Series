//
//  ContentView.swift
//  Day_95_Milestone
//
//  Created by Dexter Ramos on 9/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            DiceCollectionView(numberOfDice: 9, diceSides: 6)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
