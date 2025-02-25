//
//  DiceConfigVM.swift
//  Day-95-Milestone
//
//  Created by Dexter Ramos on 2/20/25.
//
import SwiftUI

extension DiceConfigView {
    class ViewModel: ObservableObject {
        @Published var config: Config
        let saveAction: (Config) -> Void
        
        init(config: Config, saveAction: @escaping (Config) -> Void) {
            self.config = config
            self.saveAction = saveAction
        }
        
        func saveConfig() {
            saveAction(config)
        }
    }
}
