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
    
    init(config: Config = Config(), saveAction: @escaping (Config) -> Void) {
        let configCopy = config.copy()
        self._vm = StateObject(wrappedValue: ViewModel(config: configCopy, saveAction: saveAction))
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
                Picker("Number of Die", selection: $vm.config.numberOfDie) {
                    ForEach(pickerOptionsDieCount, id: \.self) { count in
                        Text("\(count)")
                            .tag(count)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section("Select Number of side") {
                Picker("Number of side", selection: $vm.config.numberOfSide) {
                    ForEach(pickerOptionsSideCount, id:\.self) { side in
                        Text("\(side)")
                            .tag(side)
                    }
                }
            }
            .pickerStyle(.segmented)
            
            Section("Interactivity") {
                Toggle("Haptics", isOn: $vm.config.isHapticsEnabled)
                Toggle("Flip animation", isOn: $vm.config.isFlipAnimationEnabled)
            }
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
