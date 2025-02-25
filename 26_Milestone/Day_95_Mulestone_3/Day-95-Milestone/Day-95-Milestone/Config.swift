//
//  Config.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//
import SwiftUI

class Config: ObservableObject {
    @Published var isFlipAnimationEnabled: Bool = false
    @Published var isHapticsEnabled: Bool = true
    @Published var numberOfDie: Int = 1
    @Published var numberOfSide: Int = 6
    
    func update(with config: Config) {
        isFlipAnimationEnabled = config.isFlipAnimationEnabled
        numberOfDie = config.numberOfDie
        numberOfSide = config.numberOfSide
        isHapticsEnabled = config.isHapticsEnabled
    }
}

extension Config: CopyableProtocol {
    func copy() -> Config {
        let config = Config()
        config.isFlipAnimationEnabled = self.isFlipAnimationEnabled
        config.numberOfDie = self.numberOfDie
        config.numberOfSide = self.numberOfSide
        return config
    }
}
