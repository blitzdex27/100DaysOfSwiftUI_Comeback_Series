//
//  DiceView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/14/25.
//

import SwiftUI

struct DiceView: View {
    
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
