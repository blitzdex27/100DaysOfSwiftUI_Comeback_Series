//
//  DiceView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/14/25.
//

import SwiftUI
import CoreHaptics

struct DiceView: View {
    @Environment(\.hapticEngine) var hapticEngine
    
    var rotation: Angle = .zero
    var scale: CGFloat = 1
    
    @State var vm: DiceVM
        
    init(dice: Dice) {
        self._vm = State(initialValue: DiceVM(dice: dice))
    }
    
    var body: some View {
        GeometryReader { proxy in
            Text(vm.diceString)
                .font(.system(size: 500, weight: .medium, design: .monospaced))
                .minimumScaleFactor(0.01)
                .frame(width: proxy.size.width, height: proxy.size.width)
                .background(.white)
                .animation(.linear, value: vm.diceString)
                .contentTransition(.numericText(value: Double(vm.dice.currentValue)))
        }
        .aspectRatio(1, contentMode: .fit)
        .scaleEffect(scale)
        .rotation3DEffect(rotation, axis: (x: 1, y: 0, z: 0))
//        .onChange(of: vm.dice.currentValue) {
//            vm.scale = 0.75
//            
//            withAnimation(.linear(duration: 0.5)) {
//                vm.rotation += .degrees(360)
//            } completion: {
//                withAnimation {
//                    vm.scale = 1
//                }
//            }
//        }
        .onChange(of: vm.dice.currentValue) {
            do {
                
                let intensity = Double(vm.dice.currentValue) / Double(vm.dice.sideCount)
                let shapness = Double(vm.dice.currentValue) / Double(vm.dice.sideCount)
                let event = CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [
                        .init(
                            parameterID: .hapticIntensity,
                            value: Float(intensity == 0 ? 1 : intensity)
                        ),
                        .init(
                            parameterID: .hapticSharpness,
                            value: Float(shapness)
                        ),
                    ],
                    relativeTime: 0.1
                )
                let pattern = try! CHHapticPattern(events: [event], parameters: [])
                let player = try hapticEngine?.makePlayer(with: pattern)
                try player?.start(atTime: CHHapticTimeImmediate)
            } catch {
                print("Haptic error: \(error)")
            }
        }
    }
}

#Preview {
    DiceView(
        dice: Dice(
            sideCount: 6
        )
    )
        .frame(width: 100)
        .background(.red)
}
