//
//  ContentView.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State var isRolling = false
    
    @State var reset = false
    
    @State var result = 0
    
    @State var useSaved = true
    
    @State var savedDiceCollection: DiceCollection?
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack {
            ResultView(result: $result)
                
            if let savedDiceCollection, useSaved {
                DiceCollectionView(isRolling: $isRolling, reset: $reset, diceCollection: savedDiceCollection, showControl: false) { results in
                    result = results.total
                } didReset: {
                    result = 0
                }

            }
            
            if !useSaved {
                DiceCollectionView(isRolling: $isRolling, reset: $reset, dieCount: 100, sideCount: 6, showControl: false) { results in
                    result = results.total
                } didReset: {
                    result = 0
                }
            }
            
            
    
            
            HStack {
                Button(role: .destructive) {
                    reset = true
                    
                    let event = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 2)
                    let pattern = try! CHHapticPattern(events: [event], parameters: [])
                    let player = try! engine?.makePlayer(with: pattern)
                    try! player?.start(atTime: CHHapticTimeImmediate)
                } label: {
                    Text("Reset")
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                Button {
                    isRolling = true
                    
                    if let savedDiceCollection {
                        var events = [CHHapticEvent]()
                        
                        for i in stride(from: 0, to: Double(savedDiceCollection.dice.count), by: 0.1) {
                            
                            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
                            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
                            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
                            events.append(event)
                        }
                        
                        
                        do {
                            let pattern = try CHHapticPattern(events: events, parameters: [])
                            let player = try engine?.makePlayer(with: pattern)
                            try player?.start(atTime: CHHapticTimeImmediate)
                        } catch {
                            
                        }
                    }
                    
                } label: {
                    Text("Roll")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }

        }
        .onAppear(perform: {
            do {
                engine = try CHHapticEngine()
                try engine?.start()
            } catch {
                print(error.localizedDescription)
            }
            Task {
                do {
                    if useSaved {
                        savedDiceCollection = try await DiceCollection.load()
                        result = savedDiceCollection?.rollResults?.total ?? 0
                    }
                } catch {
                    useSaved = false
                }
            }
        })
        .padding()
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    struct ResultView: View {
        
        @Binding var result: Int
        
        var body: some View {
            HStack {
                Text("Value")
                    .font(.subheadline)
                Spacer()
                Text("\(result)")
                    .font(.largeTitle)
                    .monospaced()
                    .contentTransition(.numericText(value: Double(result)))
                
                Spacer()
            }
            .animation(.default, value: result)
        }
    }
}
