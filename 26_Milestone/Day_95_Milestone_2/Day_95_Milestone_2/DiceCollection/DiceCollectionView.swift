//
//  DiceCollectionView.swift
//  Day_95_Milestone_2
//
//  Created by Dexter Ramos on 9/25/24.
//

import SwiftUI

struct DiceCollectionView: View {
    
    @State var viewModel: ViewModel
        
    let didFinishRoll: (DiceCollection.RollResults) -> Void
    let didReset: (() -> Void)?
    
    private var gridItems: [GridItem] {
        let count = viewModel.dice.count
        let sqrt = sqrtf(Float(count))
        let rounded = Int(sqrt.rounded())
        
        return (0..<rounded).map({ _ in GridItem() })
        
    }
    
    
    init(
        diceCollection: DiceCollection,
        didFinishRoll: @escaping (DiceCollection.RollResults) -> Void,
        didReset: (() -> Void)? = nil
    ) {
        self._viewModel = State(wrappedValue: ViewModel(diceCollection: diceCollection))
        self.didFinishRoll = didFinishRoll
        self.didReset = didReset
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: gridItems) {
                    ForEach(viewModel.dice) { die in
                        DieView(die: die) { result in
                            print(result)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            
        }
        .onChange(of: viewModel.diceCollection.rollResults, {
            if let rollResults = viewModel.diceCollection.rollResults {
                didFinishRoll(rollResults)
            } else {
                didReset?()
            }
        })
    }
}

#Preview {
    @Previewable @State var diceCollection: DiceCollection = DiceCollection(dice: [
        Die(sideCount: 6),
        Die(sideCount: 6),
    ])
     return DiceCollectionView(diceCollection: diceCollection) { results in
        
    }
}
