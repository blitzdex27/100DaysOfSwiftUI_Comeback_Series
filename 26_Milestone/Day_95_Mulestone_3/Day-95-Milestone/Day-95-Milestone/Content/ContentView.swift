//
//  ContentView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/14/25.
//

import SwiftUI
import SwiftData

struct ContentView<VM: ContentVMProtocol>: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.rollResultStore) private var store
    @Environment(\.config) private var config

    @State var isRolling: Bool = false
    @State var canReset: Bool = false
    @State var showingResults: Bool = false
    @State var showingConfig: Bool = false
    
    @StateObject var vm: VM
    
    init(viewModel: VM) {
        _vm = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        @Bindable var diceCollection = vm.diceCollection
        
        NavigationStack {
            VStack {
                Text("\(vm.diceCollection.currentValue)")
                    .font(.system(size: 50, weight: .black, design: .monospaced))
                    .animation(.default, value: Double(vm.diceCollection.currentValue))
                    .contentTransition(.numericText(value: Double(vm.diceCollection.currentValue)))
                
                DiceCollectionView(
                    isRolling: $isRolling,
                    collection: vm.diceCollection,
                    didEndRolling: didEndRolling
                )
                .accessibilityAddTraits(.isButton)
                .accessibilityHint(Text("Dice collection of \(config.numberOfDie) dice. Tap to roll"), isEnabled: !isRolling)
                .allowsHitTesting(!isRolling)
                .onTapGesture {
                    if canReset {
                        reset()
                    } else if !canReset && !isRolling {
                        isRolling = true
                    }
                    
                }
            }
            .toolbar {
                Button("History") {
                    showingResults = true
                }
                Button("Config") {
                    showingConfig = true
                }
            }
            .sheet(isPresented: $showingResults) {

                NavigationStack {
                    RollResultsView(viewModel: RollResultsView.ViewModel(store: store))
                }
                .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $showingConfig) {
                NavigationStack {
                    
                    DiceConfigView(config: config) { config in

                        vm.updateCollection(dieCount: config.numberOfDie, sideCount: .constant(config.numberOfSide))
                        self.config.update(with: config)
                        isRolling = false
                        canReset = false
                    }
                }
                .presentationDetents([.medium])
            }
        }
        .onAppear {
            vm.store.modelContext = modelContext
        }

    }

    
    func reset() {
        vm.reset()
        isRolling = false
        canReset = false
    }
    
    func didEndRolling() {
        let resultAnnouncement = "The result of rolling \(config.numberOfDie) dice is \(vm.diceCollection.currentValue)."
        
        let tapToResetAnnouncement = "Double tap to reset."
        let announcement = "\(resultAnnouncement) \(tapToResetAnnouncement)"
        UIAccessibility.post(notification: .announcement, argument: announcement)
        
        vm.saveRollResult()
        canReset = true
    }
}

#Preview {
    ContentView(viewModel: .defaultVM(store: .defaultValue))

}
