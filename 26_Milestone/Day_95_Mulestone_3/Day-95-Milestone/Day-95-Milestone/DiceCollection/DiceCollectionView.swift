//
//  DiceCollectionView.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/15/25.
//

import SwiftUI

struct DiceCollectionView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var isRolling: Bool
    @State var vm: DiceCollectionVM
    let didEndRolling: () -> Void
    
    init(isRolling: Binding<Bool>, collection: DiceCollection, didEndRolling: @escaping () -> Void) {
        self._isRolling = isRolling
        self._vm = State(initialValue: DiceCollectionVM(diceCollection: collection))
        self.didEndRolling = didEndRolling
    }
    
    var columns: [GridItem] {
        let columnCount: Int = {
            if vm.diceCollection.dice.count == 2 {
                return 2
            } else {
                return Int(sqrt(Double(vm.diceCollection.dice.count)).rounded(.toNearestOrAwayFromZero))
            }

        }()
        let items = (0..<columnCount).map { _ in
            GridItem(.flexible(minimum: 20, maximum: 500))
        }
        return items
    }
    
    var diceItems: some View {
        ForEach(vm.diceCollection.dice) { dice in
            DiceView(dice: dice)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: colorScheme == .light ? .black.opacity(0.33) : .white.opacity(0.33), radius: 5)

        }
    }
    
    var body: some View {
        GeometryReader { fullView in
            
            VStack {
                if vm.diceCollection.dice.count == 1 {
                    VStack {
                        diceItems
                    }
                    
                } else {
                    LazyVGrid(columns: columns) {
                        diceItems
                    }
                }
            }
            .padding()
            .frame(width: fullView.size.width, height: fullView.size.height)
        }
        .onChange(of: isRolling) {
            if isRolling {
                Task {
//                    vm.rollAll()a
                    await vm.dynamicRoll()
                   didEndRolling()
                    isRolling = false
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var isRolling = false
    @Previewable @State var diceCollection = DiceCollection(dieCount: 1, sideCount: .constant(6))
    DiceCollectionView(
        isRolling: $isRolling,
        collection: diceCollection) {
            
        }
}
