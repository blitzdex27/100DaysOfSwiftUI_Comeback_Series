//
//  ContentVMProtocol.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//
import SwiftUI

protocol ContentVMProtocol: AnyObject, ObservableObject {
    var store: RollResultStore { get }
    
    var diceCollection: DiceCollection { get }

    @MainActor
    func saveRollResult()
    
    @MainActor
    func reset()
    
    @MainActor
    func updateCollection(dieCount: Int, sideCount: DiceCollection.SideCount)
}

extension ContentVMProtocol where Self == ContentVM {
    static func defaultVM(store: RollResultStore) -> Self {
        ContentVM(store: store)
    }
}
