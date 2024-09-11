//
//  DiceCollectionView.swift
//  Day_95_Milestone
//
//  Created by Dexter Ramos on 9/11/24.
//

import SwiftUI

struct DiceCollectionView: View {
    
    let numberOfDice: Int
    let diceSides: Int
    
    @State var faceUpSides: [Int] = []
    @State var rollers: [Bool] = []
    @State private var hasRolled = false
        
    init(numberOfDice: Int, diceSides: Int) {
        self.numberOfDice = numberOfDice
        self.diceSides = diceSides
        _faceUpSides = State(wrappedValue: Array(repeating: 1, count: numberOfDice))
        _rollers = State(wrappedValue: Array(repeating: false, count: numberOfDice))
    }
    
    private let gridItems = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    var body: some View {
        VStack {
            LazyVGrid(columns: gridItems) {
                ForEach(0..<numberOfDice, id: \.self) { index in
                    DiceView(faceUpSide: $faceUpSides[index], numberOfSides: numberOfDice, isRolling: $rollers[index])
                }
            }
            .padding()
            if hasRolled {
                Button("Reset", action: resetAllDice)
            } else {
                Button("Roll", action: rollAllDice)
            }
            
        }
    }
    
    func rollAllDice() {
        for index in 0..<rollers.count {
            rollers[index] = true
        }
        hasRolled = true
    }
    
    func resetAllDice() {
        for index in 0..<rollers.count {
            rollers[index] = false
            faceUpSides[index] = 1
        }
        hasRolled = false
    }
}

#Preview {
    DiceCollectionView(numberOfDice: 6, diceSides: 6)
}
