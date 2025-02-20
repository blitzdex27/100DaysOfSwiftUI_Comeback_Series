//
//  DiceConfigView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/18/25.
//

import SwiftUI

struct DiceConfigView: View {
    @Environment(\.dismiss) var dismiss
            
    @StateObject var vm: ViewModel
    
    init(numberOfDie: Int = 1, numberOfSide: Int = 6, saveAction: @escaping (_ numberOfDie: Int, _ numberOfSide: Int) -> Void) {
        self._vm = StateObject(wrappedValue: ViewModel(numberOfDie: numberOfDie, numberOfSide: numberOfSide, saveAction: saveAction))
    }
    
    @State var pickerOptionsDieCount: [Int] = {
        (1...100).filter({
            let square = sqrt(Double($0))
            let rounded = Double(Int(square))
            return square == rounded
            
        })
    }()
    
    @State var pickerOptionsSideCount: [Int] = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        Form {
            Section("Select Number of Die") {
                Picker("Number of Die", selection: $vm.numberOfDie) {
                    ForEach(pickerOptionsDieCount, id: \.self) { count in
                        Text("\(count)")
                            .tag(count)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section("Select Number of side") {
                Picker("Number of side", selection: $vm.numberOfSide) {
                    ForEach(pickerOptionsSideCount, id:\.self) { side in
                        Text("\(side)")
                            .tag(side)
                    }
                }
            }
            .pickerStyle(.segmented)
        }
        .toolbar {
            Button("Done") {
                vm.saveConfig()
                dismiss.callAsFunction()
            }
        }
    }
}

//#Preview {
//    @Previewable @State var diceCollection = DiceCollection(dieCount: 6, sideCount: 6)
//    DiceConfigView(diceCollection: $diceCollection)
//}
