//
//  DiceCollectionView.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/25/24.
//

import SwiftUI

struct DiceCollectionView: View {
    
    @State var viewModel: ViewModel
    
    @Binding var isRolling: Bool
    
    @Binding var reset: Bool
    
    @State private var isRollingArray: [Bool]
    
    var showControl: Bool
    
    let didFinishRoll: (DiceCollection.RollResults) -> Void
    let didReset: () -> Void
    
    private var gridItems: [GridItem] {
        let count = viewModel.dice.count
        let sqrt = sqrtf(Float(count))
        let rounded = Int(sqrt.rounded())
        
        return (0..<rounded).map({ _ in GridItem() })
        
    }
    
    init(
        isRolling: Binding<Bool>,
        reset: Binding<Bool>,
        dieCount: Int,
        sideCount: Int = 6,
        showControl: Bool = true,
        didFinishRoll: @escaping (DiceCollection.RollResults) -> Void,
        didReset: @escaping () -> Void
    ) {
        self.viewModel = ViewModel(dieCount: dieCount, sideCount: sideCount)
        self._isRolling = isRolling
        self._reset = reset
        self.showControl = showControl
        self.didFinishRoll = didFinishRoll
        self.isRollingArray = Array(repeating: false, count: dieCount)
        self.didReset = didReset
    }
    
    init(
        isRolling: Binding<Bool>,
        reset: Binding<Bool>,
        diceCollection: DiceCollection,
        showControl: Bool = true,
        didFinishRoll: @escaping (DiceCollection.RollResults) -> Void,
        didReset: @escaping () -> Void
    ) {
        self.viewModel = ViewModel(diceCollection: diceCollection)
        self._isRolling = isRolling
        self._reset = reset
        self.showControl = showControl
        self.didFinishRoll = didFinishRoll
        self.isRollingArray = Array(repeating: false, count: diceCollection.dice.count)
        self.didReset = didReset
    }
    
    var body: some View {
        VStack {
            if showControl {
                Button("Roll") {
                    isRolling = true
                }
                Button("Reset", action: viewModel.resetAll)
            }
            ScrollView {
                LazyVGrid(columns: gridItems) {
                    ForEach(viewModel.dice) { die in
                        if let index = viewModel.dice.firstIndex(where: { $0 == die }) {
                            
                            DieView(isRolling: $isRollingArray[index], die: die, showControl: false) { result in
                                print(result)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }

                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            
        }
        .onChange(of: isRolling, {
            if isRolling {
                viewModel.roll()
                let results = DiceCollection.RollResults(dice: viewModel.dice)
                    didFinishRoll(results)
                
                isRolling = false
            }
        })
        
        .onChange(of: reset, {
            if reset {
                viewModel.resetAll()
                didReset()
                reset = false
            }
        })
//        ScrollView {
//            ForEach(0..<viewModel.dice.count, id: \.self) { index in
//                DieView(isRolling: $isRollingArray[index], die: viewModel.dice[index], showControl: true) { result in
//                    print(result)
//                }
////                .frame(height: 400)
//                .background(.green)
//            }
//        }
    }
}

#Preview {
    @Previewable @State var isRolling: Bool = true
    @Previewable @State var reset = false
    return DiceCollectionView(isRolling: $isRolling, reset: $reset, dieCount: 4) { results in
        
    } didReset: {
        
    }
}
