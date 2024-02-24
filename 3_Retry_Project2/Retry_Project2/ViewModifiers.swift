//
//  ViewModifiers.swift
//  Retry_Project2
//
//  Created by Dexter Ramos on 2/24/24.
//

import SwiftUI

struct LargeBlueFontModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func largeBlueFont() -> some View {
        modifier(LargeBlueFontModifer())
    }
}
