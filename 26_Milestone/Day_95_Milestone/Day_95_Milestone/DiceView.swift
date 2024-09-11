//
//  DiceView.swift
//  Day_95_Milestone
//
//  Created by Dexter Ramos on 9/11/24.
//

import SwiftUI

struct DiceView: View {
    @Binding var faceUpSide: Int
    var numberOfSides: Int = 6
    @Binding var isRolling: Bool
    
    init(faceUpSide: Binding<Int>, numberOfSides: Int, isRolling: Binding<Bool>) {
        self._faceUpSide = faceUpSide
        self.numberOfSides = numberOfSides
        self._isRolling = isRolling
    }
    
    var body: some View {
        VStack {
            Text("\(faceUpSide)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .border(Color.black)
        }
        .onChange(of: isRolling) {
            if isRolling {
                roll()
            } else {
                stopRolling()
            }
        }
    }
    
    func roll() {
        faceUpSide = Int.random(in: 1...numberOfSides)
    }
    
    func stopRolling() {
        
    }
 
}

#Preview {
    @Previewable @State var faceUpSide: Int = 1
    DiceView(faceUpSide: $faceUpSide, numberOfSides: 6, isRolling: .constant(false))
}
