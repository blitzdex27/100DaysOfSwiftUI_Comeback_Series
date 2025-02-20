//
//  ContentView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/14/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @State var isRolling: Bool = false
    @State var canReset: Bool = false
    @State var showingResults: Bool = false
    @State var showingConfig: Bool = false
    
    @State var vm: ContentVM = ContentVM()
    
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
                    RollResultsView()
                }
                .presentationDetents([.medium, .large])
            }
            .sheet(isPresented: $showingConfig) {
                NavigationStack {
                    
                    DiceConfigView(numberOfDie: vm.diceCollection.dice.count, numberOfSide: vm.diceCollection.dice[0].sideCount) { numberOfDie, numberOfSide in
                        vm.diceCollection.update(dieCount: numberOfDie, sideCount: numberOfSide)
                        isRolling = false
                        canReset = false
                    }
                }
                .presentationDetents([.medium])
            }
        }

    }

    
    func reset() {
        vm.reset()
        isRolling = false
        canReset = false
    }
    
    func didEndRolling() {
        vm.saveRollResult()
        canReset = true
    }
}

#Preview {
    ContentView()
}
