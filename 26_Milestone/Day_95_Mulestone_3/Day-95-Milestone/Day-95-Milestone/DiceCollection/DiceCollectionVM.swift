//
//  DiceCollectionVM.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/19/25.
//
import SwiftUI
import Combine

@Observable
class DiceCollectionVM {
    private var cancellables = Set<AnyCancellable>()
    
    private(set) var diceCollection: DiceCollection
    
    init(diceCollection: DiceCollection) {
        self.diceCollection = diceCollection
    }
    
    @MainActor
    func rollAll() {
        diceCollection.rollAll { [weak self] _ in
            guard let self else { return }
            diceCollection.currentValue = diceCollection.dice.getResultSum()
        }
    }
    
    func dynamicRoll() async {
        
        let prefixMax = 20
        
        await withTaskGroup(of: Void.self) { group in
            for dice in diceCollection.dice {
                group.addTask {
                    let transientCount = Int.random(in: 1...min(prefixMax, dice.sideCount))
                    let transientValues: [Int] = await MainActor.run {
                        (1...transientCount).map { _ in dice.roll() } 
                    }// (1..<transientCount).map({ _ in dice.roll() })
                    
                    for transientValue in transientValues {
                        
                        await MainActor.run {
                            dice.currentValue = transientValue
                            self.diceCollection.currentValue = self.diceCollection.dice.getResultSum()
                        }
                        try! await Task.sleep(for: .seconds(0.2))
                    }
                        await MainActor.run {
                            dice.currentValue = dice.roll()
                            self.diceCollection.currentValue = self.diceCollection.dice.getResultSum()
                        }
      
                    
                }
            }
            
            for await _ in group {
                
            }
            
            
        }
        

    }
}
