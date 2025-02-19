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
        diceCollection.rollAll()
    }
    
    func dynamicRoll() async {
        
        let prefixMax = 20
        
        await withTaskGroup(of: Void.self) { group in
            for dice in diceCollection.dice {
                group.addTask {
                    let transientCount = await Int.random(in: 1...min(prefixMax, dice.sideCount))
                    let transientValues: [Int] = await MainActor.run {
                        (1...transientCount).map { _ in dice.roll() } 
                    }// (1..<transientCount).map({ _ in dice.roll() })
                    
                    for transientValue in transientValues {
                        
                        DispatchQueue.main.async {
                            dice.currentValue = transientValue
                        }
                        try! await Task.sleep(for: .seconds(0.2))
                    }
                    DispatchQueue.main.async {
                        dice.currentValue = dice.roll()
                    }
      
                    
                }
            }
            
            for await _ in group {
                
            }
            
            
        }
        

    }
}
