//
//  AmountModifier.swift
//  10_Project7
//
//  Created by Dexter Ramos on 6/24/24.
//

import Foundation
import SwiftUI

struct AmountStyleModifier: ViewModifier {
    let amount: Double
    func body(content: Content) -> some View {
        switch amount {
        case ..<10:
            content.foregroundStyle(.green)
        case 10..<100:
            content.foregroundStyle(.orange)
        case 100...:
            content.foregroundStyle(.red)
        default:
            content.foregroundStyle(.secondary)
        }
    }
}

extension Text {
    func applyAmountStyle(for amount: Double) -> some View {
        return modifier(AmountStyleModifier(amount: amount))
    }
}
