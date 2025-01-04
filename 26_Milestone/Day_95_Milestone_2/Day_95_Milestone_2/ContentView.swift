//
//  ContentView.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/24/24.
//

import SwiftUI
import CoreHaptics
import OSLog

struct ContentView: View {
    
    @State var defaultDiceCount: Int = 1
    
    @State var defaultSideCount: Int = 6
    
    @State var result = 0
    
    @State var useSaved = true
    
    @State var diceCollection: DiceCollection?
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack {
            ResultView(result: $result)
                
            if let diceCollection {
                DiceCollectionView(diceCollection: diceCollection) { results in
                    result = results.total
                } didReset: {
                    result = 0
                }
            }
            
            Picker("Die Count", selection: $defaultDiceCount) {
                ForEach(1..<100) { num in
                    Text("\(num)")
                        .tag(num)
                }
            }
            
            HStack {
                Button(role: .destructive) {
                    guard let diceCollection else {
                        return
                    }
                    diceCollection.reset(at: IndexSet(0..<diceCollection.dice.count))
                    Task {
                        try await DiceCollection.delete()
                    }
                    
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
                    diceCollection?.dynamicRoll(completion: { _ in
                        
                    })
                    Task {
                        try await diceCollection?.save()
                    }
                    
                    if let diceCollection {
                        var events = [CHHapticEvent]()
                        
                        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1))
                        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1))
                        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0.1)
                        events.append(event)
                        
                        
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
                        diceCollection = try await DiceCollection.load()
                        result = diceCollection?.rollResults?.total ?? 0
                    } else {
                        diceCollection = DiceCollection.make(diceCount: defaultDiceCount, sideCount: defaultSideCount)
                    }
                } catch {
                    diceCollection = DiceCollection.make(diceCount: defaultDiceCount, sideCount: defaultSideCount)
                }
            }
        })
        .onChange(of: defaultDiceCount, {
            
            os_log(.info, "defaultDiceCount: \(defaultDiceCount)")
            diceCollection = DiceCollection.make(diceCount: defaultDiceCount, sideCount: defaultSideCount)
            
        })
        .onChange(of: defaultSideCount, {
            Task {
                try await DiceCollection.delete()
                diceCollection = DiceCollection.make(diceCount: defaultDiceCount, sideCount: defaultSideCount)
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
