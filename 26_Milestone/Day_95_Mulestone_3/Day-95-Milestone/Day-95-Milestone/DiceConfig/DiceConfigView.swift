//
//  DiceConfigView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/18/25.
//

import SwiftUI

struct DiceConfigView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var diceCollection: DiceCollection
    @State var numberOfDie: Int = 1
    @State var numberOfSide: Int = 6
    var body: some View {
        Form {
            Picker("Number of Die", selection: $numberOfDie) {
                ForEach(1..<101) { count in
                    Text("\(count)")
                        .tag(count)
                }
            }
            Picker("Number of side", selection: $numberOfSide) {
                ForEach(1..<101) { side in
                    Text("\(side)")
                        .tag(side)
                }
            }
        }
        .toolbar {
            Button("Done") {
                diceCollection.update(dieCount: numberOfDie, sideCount: numberOfSide)
                dismiss.callAsFunction()
            }
        }
    }
}

#Preview {
    @Previewable @State var diceCollection = DiceCollection(dieCount: 6, sideCount: 6)
    DiceConfigView(diceCollection: $diceCollection)
}
